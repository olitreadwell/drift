# simolus3/drift context
> refreshed 2026-09-03 | upstream default: develop @ 70db2cd555268cf7d56d2e5510407ea8c04efccf

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

## Mined gaps (discovered, not yet attempted)
- (filled during the run; see tried-repos.jsonl note)
