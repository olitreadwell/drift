@TestOn('vm')
library;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

/// Regression test for https://github.com/simolus3/drift/issues/3867
///
/// When a write happens inside a nested transaction and the database uses a
/// [MultiExecutor] with separate read and write connections, streams watching
/// the affected tables were invalidated while the outer transaction was still
/// open. The re-query then ran against the read connection, which hadn't seen
/// the (uncommitted) write yet, and no later invalidation was emitted - so the
/// stream got stuck reporting the pre-transaction state forever.
void main() {
  const label = 'written';

  test(
    'nested transaction notifies streams once the outer one commits',
    () async {
      final dir = Directory.systemTemp.createTempSync('drift_3867');
      addTearDown(() => dir.deleteSync(recursive: true));

      NativeDatabase open() {
        final file = File('${dir.path}/db.sqlite');
        return NativeDatabase(
          file,
          setup: (db) => db.execute('PRAGMA journal_mode = WAL;'),
        );
      }

      final executor = MultiExecutor(read: open(), write: open());
      final database = ReproDb(executor);
      addTearDown(database.close);

      final stream = database.watchLabels().asBroadcastStream();
      final subscription = stream.listen(null);
      addTearDown(subscription.cancel);

      await expectLater(stream, emits(isEmpty));

      // The expectation must be registered before the write: a broadcast stream
      // does not replay. Close the stream on timeout so a stuck stream fails the
      // test instead of hanging it.
      final notified = expectLater(
        stream.timeout(
          const Duration(seconds: 3),
          onTimeout: (sink) => sink.close(),
        ),
        emitsThrough([label]),
      );

      await database.transaction(() async {
        await database.transaction(() => database.insert(label));
        // Some more work in the outer transaction after the inner one completed.
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });

      expect(await database.readLabels(), [label]);
      await notified;
    },
  );
}

class ReproDb extends GeneratedDatabase {
  ReproDb(super.executor);

  late final VersionedTable items = VersionedTable(
    entityName: 'items',
    isStrict: false,
    withoutRowId: false,
    attachedDatabase: this,
    tableConstraints: const [],
    columns: [
      (table) => GeneratedColumn<String>(
        'label',
        table,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ),
    ],
  );

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables => [items];

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (_) => customStatement(
      'CREATE TABLE IF NOT EXISTS items (label TEXT NOT NULL)',
    ),
  );

  Stream<List<String>> watchLabels() => customSelect(
    'SELECT label FROM items ORDER BY label',
    readsFrom: {items},
  ).watch().map((rows) => [for (final r in rows) r.read<String>('label')]);

  Future<List<String>> readLabels() async {
    final rows = await customSelect('SELECT label FROM items').get();
    return [for (final r in rows) r.read<String>('label')];
  }

  Future<void> insert(String label) => customInsert(
    'INSERT INTO items (label) VALUES (?)',
    variables: [Variable<String>(label)],
    updates: {items},
  );
}
