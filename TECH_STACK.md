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
- **No networking by default.** Serverless; **no runtime API keys** baked in.

## Architecture conventions
- **Pure domain core over an injected `Clock`.** Engine / state machines have no I/O, so
  they're fully unit-testable with a fake clock; the DB and platform are driven *from* the
  domain, never mixed into it.
- **`lib/` layout:** `core` (theme, clock, format) · `data` (db, repositories, backup) ·
  `domain` (pure logic) · `ui` · `l10n`.
- **History is immutable to edits** where a domain has a log (snapshot at write time).

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
- **Landing page** on the app's domain via **GitHub Pages** (`docs/` folder + `CNAME` +
  custom-domain DNS).

## Per-app additions
Apps add libraries their concept needs — e.g. checkfuchs: `flutter_local_notifications` +
`timezone`; knabberfuchs: `mobile_scanner`, ML Kit OCR, `health`. The base above stays
constant.

## Open stack questions (grill as apps are built)
- Confirm `flutter_local_notifications` + `timezone` as the **standard** local-notification
  pair across apps.
- Standard backup/restore helper (shared `archive` + `share_plus` + `file_selector` flow)
  — extract to a shared snippet vs. re-implement per app.
- Minimum SDK / target API baseline to pin family-wide.
