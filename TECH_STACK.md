# Fuchsbau — Base Tech Stack

The shared technical foundation. A new fuchs app starts from here and adds only what its
concept needs.

## Stack
- **Flutter / Dart** — Android-first, iOS kept possible.
- **Riverpod** — state management.
- **drift / SQLite** — local-first persistence with migrations.
- **Material 3** — theming (see [DESIGN.md](./DESIGN.md)).
- **intl + flutter_localizations** — l10n (en / de / fr / it); ARB files, no hardcoded
  user-facing strings.
- **flutter_local_notifications + timezone** — the **standard** local-reminder pair; no
  push, no server. `timezone` keeps day-boundary / DST math correct.
- **No networking by default.** Serverless; **no runtime API keys** baked in.

## Architecture conventions
- **Pure domain core over an injected `Clock`.** Engine / state machines have no I/O, so
  they're fully unit-testable with a fake clock; the DB and platform are driven *from* the
  domain, never mixed into it.
- **`lib/` layout:** `core` (theme, clock, format) · `data` (db, repositories, backup) ·
  `domain` (pure logic) · `ui` · `l10n`.
- **History is immutable to edits** where a domain has a log (snapshot at write time).
- **Router-less navigation.** Imperative `Navigator` + an `IndexedStack`/`TabBar` for
  top-level destinations; `push` for sheets/detail. No `go_router` — it adds ceremony a
  single-stack app doesn't need.
- **Date/time = vanilla `DateTime` + `intl`** (+ `timezone` where day-boundaries matter).
  No extra date library.
- **Local-only keys = `INTEGER` autoincrement.** No sync ⇒ no UUIDs.

## Repo skeleton
```
CLAUDE.md          working guide for Claude (toolchain, conventions)
PLAN.md            roadmap + architecture + decisions
design-concept.md  the data model / state machines (if the app has a rich model)
DESIGN_SYSTEM.md   app-specific design — inherits Fuchsbau, records deviations
examples/ui/       static HTML mockups = visual canon
docs/              GitHub Pages landing site (+ CNAME for the app's domain)
```

## Toolchain
- Flutter runs in a **distrobox container named `flutter`** (not on PATH):
  ```sh
  distrobox enter flutter -- bash -lc 'flutter <cmd>'
  ```
- Analyze / test: `flutter analyze` · `flutter test`. l10n via `flutter gen-l10n`.

## Backup
- **ZIP** = SQLite snapshot + JSON export; fully local, no cloud lock-in. Manifest carries
  the schema version.

## Release
- **fastlane** for metadata + upload. Phone builds **arm64-only**
  (`flutter build apk --release --target-platform android-arm64`); `flutter build
  appbundle` for the Play Store (per-device split).
- **App ids & domains:** one collection domain — **fuchsnest.ch** — instead of a domain
  per app. New apps use the id `ch.fuchsnest.<appname>` (e.g. `ch.fuchsnest.knobelfuchs`);
  apps released before this convention keep their historical ids/domains.
- **Landing page** via **GitHub Pages** (`docs/` folder + `CNAME`), under fuchsnest.ch for
  new apps (subdomain vs. path per app).
- **Baseline:** min Android API **26** (adaptive icons), family-wide.

## Per-app additions
Apps add libraries their concept needs — e.g. checkfuchs: `flutter_local_notifications` +
`timezone`; knabberfuchs: `mobile_scanner`, ML Kit OCR, `health`. The base above stays
constant.

## Still open
- **Shared backup/restore helper** (`archive` + `share_plus` + `file_selector`) — extract
  to a reusable snippet/package vs. re-implement per app. Decide when a second app needs it.
