# simolus3/drift context
> refreshed 2026-09-23 | upstream default: develop @ 9d2330b31fe0788d9911a7d8c09fdf976b770fd2

## Identity & policies
- upstream: simolus3/drift, default branch `develop`, primary language Dart, English-first (yes — all docs/README in English).
- CLA/DCO: none (no CLA bot, no DCO in CONTRIBUTING).
- AI-assisted PR policy: unstated (CONTRIBUTING.md has no AI mention; no disclosure required).
- signed commits required: no (branch protection `required_signatures` not set).
- PR template: none (no PULL_REQUEST_TEMPLATE in repo or org). Use pipeline fallback body.
- external tracker: github (issues + PRs on GitHub).

## Conventions (verified from merged PRs)
- branch naming: mixed; `fix/...`, `docs/...`, `feature/...`, `feat/...` all seen. Use `docs/...` for doc/typo cleanup.
- commit style: plain imperative / conventional-ish ("Fix quoted link targets and two typos in the docs", "doc(sqlite): wrong version in doc 3.52 -> 3.53"). No strict Conventional Commits requirement.
- test command: `dart test` (per package); CI runs `dart format -o none --set-exit-if-changed .`, `dart analyze --fatal-infos --fatal-warnings`, `dart run drift_dev analyze`, `dart test` in docs job; per-package jobs in main.yml.
- CI: GitHub Actions (main.yml), melos monorepo. Fork CI should run on PRs.
- how outside PRs get merged: responsive — many external merges (usmamalik345, meliharik, mohanedy, Yusufihsangorgel, zkang93, ViveNoctem, dbebawy, shenlong-tanwen, homeserve-lsaudon, eliaxelang007, rrbharath, Hu-Wentao, hhDream, ersanKolay, soumas). Docs/typo PRs from outsiders merge (e.g. "Fix quoted link targets and two typos in the docs", "doc(sqlite): wrong version in doc 3.52 -> 3.53", "Fix formatting and punctuation in README.md"). Median time-to-merge fast (days).

## Maintainer picture
- active maintainer: simolus3 (core). Community contributors actively merged through 2026-08-31.
- areas in flight: drift3 preview, analyzer support, wasm, DuckDB dialect, devtools.

## Issue-area health
- Issue #3709 (manager string filter contains() Cyrillic) — candidate, not used for trivial pass.
- Trivial loop target: docs/typo/link cleanup across README + docs/content.

## Gap ledger (dedupe — READ FIRST, never re-pick)
- `2026-09-03` trivial-fix pass (typos) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/1 — 14 doc typos in 10 files (CONTRIBUTING.md, 9 docs pages).
- `2026-09-09` trivial-fix pass (typos) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/4 — 12 doc/issue-template typo + duplicated-word fixes in 10 files.
- `2026-09-09` trivial-fix pass (typos + broken links) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/5 — 12 meaning-preserving fixes in 8 files: `thats`->`that's`, Wikipedia Window function link encoded (was 404), legacy.electric-sql.com -> electric-sql.com, `compatiblity`, `whereever`/`unecessary`/`correclty`, `unecessary`, `Exlude`->`Exclude` x4 in 2 build configs. CI green on fork (flaky firefox OPFS web test passed on rerun, unrelated to docs-only change).

- `2026-09-13` prior PRs #4/#5 trivial fixes landed upstream via commit 00d2f2e8b "Fix more typos" (Simon Binder, Co-authored-by: olitreadwell) — those gaps are closed; PR #1 already merged as upstream #3853.
- `2026-09-23` fork PR #5 closed (upstream promotion simolus3/drift#3857 was closed without merging; prior fixes already merged via 00d2f2e8b).
- `2026-09-23` trivial-fix pass (typos + duplicated words) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/11 — 16 meaning-preserving fixes in 10 files (drift + sqlparser Dart doc comments + sqlparser parse-error strings): `sychronously`->synchronously, `instantating`->instantiating, `Te`->The, `a a`->a x3, `an an`->an, `to to`->to x2, `ot`->to, `and and`->and x2, and `paranthesis`->parenthesis x4 + `for for`->for in parser.dart. All verified in current upstream develop; no overlap with PRs #1/#4/#5 (already merged upstream). Non-draft fork PR, base=fork develop. Fork CI running.
- `2026-09-23` repo-audit dead-link pass (loop.sh, ANY-type) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/12 — 3 verified-404 links repointed to live 200 targets: expressions.md Wikipedia `Window_function_(SQL)` encoded `%28SQL%29` (markdown truncates the destination at the raw paren, was 404); streams.md riverpod `docs/providers/stream_provider` -> `docs/concepts2/providers`; drift_dev/CHANGELOG.md `docs/using-sql/drift_files/#nested-results` -> `sql_api/drift_files/#nested-results`. Each replacement re-curl-verified 200 at fix time. Deduped (no upstream open/closed/merged PR touches these). All substantive fork CI green; one flaky 'firefox dart2js' web-integration check (LateInitializationError: Field 'driver' has not been initialized) fails intermittently while a parallel instance on the identical commit passes - documented flake class from PRs #5/#11, unrelated to a docs-only diff. Dropped: droidcon.com Fluttercon talk link in server_sync.md is 404 with no clean live replacement (Wayback-only), left untouched per evidence rule.


- `2026-09-09` docs typo pass (PR #4): loosing->losing (migrations/tests), doesnt->doesn't (examples/existing_databases), implemtation->implementation (drift_testcases README), ontop->on top (guides/migrating_to_drift), Aditional/aditional->Additional/additional (2 issue templates), the-the x3 + statement-statement (4 docs pages).


  - `2026-09-24` issue #3867 (.watch not emitting in nested transactions with MultiExecutor) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/13 — root-cause bug verified in current upstream develop 9d2330b31: in `drift/lib/src/runtime/api/connection_user.dart`, nested `Transaction` was constructed against `this`, so stream invalidation dispatched when the inner savepoint released while the outer transaction was still open and the read-side requery missed the uncommitted write. 1-line fix `Transaction(this,...)` -> `Transaction(resolved,...)`. Regression test `drift/test/integration_tests/regress_3867_test.dart` (VersionedTable+GeneratedColumn, no codegen, separate WAL `MultiExecutor`, watch via `customSelect(..., readsFrom:{items}).watch()`). Before fix the new test fails (stream never emits), after fix it passes; `dart analyze`/`dart format` clean; full `test/database`+`test/engines`+manager suites green. Fork CI green except the documented flaky 'firefox dart2js' web-integration check (LateInitializationError: Field 'driver' has not been initialized), unrelated to a Dart-core+test diff; caveat documented in PR body per known_blockers. Non-draft fork PR, base=fork develop, single commit 93a853e1a.
- `2026-09-24` trivial-fix pass (doc-comment/code-comment typos, loop-trivial) — outcome: pr-opened https://github.com/olitreadwell/drift/pull/15 — 20 meaning-preserving typo fixes in 10 files (5 drift_dev, 5 sqlparser), all in Dart `///` doc comments and `//` comments (no behavior change): `furhter`, `defualts`, `increate` x2, `overriden`, `occuring`, `doesnt`, `therefor`, `convertions` x2, `defenition`, `otional`, `identifer`, `seperated`, `constrct`, `analyis`, `acutal`, `ony`, `ambigious`, `overal`. Deduped: no upstream open/closed/merged PR touches these; none overlap PRs #1/#4/#5 (merged upstream) or the closed #11 (its parser.dart `paranthesis` + drift/lib typos untouched). Verified in standalone sqlparser copy: `dart analyze` clean + full `dart test` 747 green; standalone drift_dev `dart analyze` clean on touched files. Branch docs/trivial-cleanup off fork develop @ 9d2330b31, single commit 9a3cb30ae (+20/-20, under max_diff_lines), non-draft, base=fork develop, PR #15. Fork CI: all substantive jobs green (drift package, drift_dev, sqlparser, Documentation, Integration + migration tooling, test_flutter, drift_web_ddc, web dart2wasm/chrome); the known flaky `Web integration tests` firefox job failed in one instance while a parallel instance on the identical commit passed - documented flake class from PRs #5/#11/#13, unrelated to a comment-only diff; caveat in body.

## Mined gaps (discovered, not yet attempted)
- `2026-09-23` docs dead links found by curl audit: droidcon.com Fluttercon-2023 talk link (server_sync.md) 404 - only a Wayback snapshot survives, no clean live canonical; skipped pending evidence rule. status: dropped(no-live-replacement)
- `2026-09-23` issue #3709 (manager contains() Cyrillic) reviewed: maintainer confirmed it is standard SQLite text-function behaviour (English-only upper/lower/like) and gave a setup/createFunction workaround; not a code bug, effectively resolved - no drift-level fix needed. status: dropped(expected-behaviour)
- `2026-09-24` issue #3867 (nested-tx) already PR #13; re-pick avoided.
- `2026-09-24` repo-audit self-found gap (manager string filters LIKE wildcards): `StringFilters.contains/startsWith/endsWith` in `drift/lib/src/runtime/manager/filter.dart` build `LIKE '%value%'` without escaping `%`/`_`/the escape char, so values containing those characters are matched as SQL pattern wildcards rather than literally (e.g. `aText.contains("50%")` also matches "50 off", `startsWith("foo_")` also matches "fooabar"). Repro: standalone probe test (4 rows, expect literal-only match) FAILS before, PASSES after. Dedupe: no upstream issue/PR found for escaping LIKE wildcards in the manager filters. Fixed by escaping `\`, `%`, `_` and passing `ESCAPE '\'`; regression test added (`manager_filter_test.dart`). Branch `fix/manager-filter-escape-like-wildcards`, non-draft fork PR https://github.com/olitreadwell/drift/pull/14.
## Mined gaps (discovered, not yet attempted)
- `2026-09-24` (recorded above) — status: pr-opened (#14). No further unexplored high-value gap identified this cycle; remaining open issues are large features/complex bugs already tracked above.
