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


- `2026-09-09` docs typo pass (PR #4): loosing->losing (migrations/tests), doesnt->doesn't (examples/existing_databases), implemtation->implementation (drift_testcases README), ontop->on top (guides/migrating_to_drift), Aditional/aditional->Additional/additional (2 issue templates), the-the x3 + statement-statement (4 docs pages).
