# Fuchsbau — Ethos

The values every fuchs app shares. Personal, focused tools that "fit perfectly" — built
for the maker first, and anyone who thinks the same way.

## Product values
- **Local-first & serverless.** Data lives on the device. No account, no login, no server
  to run or trust.
- **Private by default.** Nothing leaves the phone unless the user *explicitly* sends it —
  and then it's disclosed. No analytics, no tracking, no telemetry.
- **Ad-free, no subscription, no dark patterns.** No nagging, no manipulation, no
  artificial gates. The app respects the user's attention and never works against them.
- **Calm.** Quiet by default; power is summoned, not imposed. Where a domain allows it,
  status is *information, never punishment*.
- **Dark + light, always.** Both first-class, following the OS with a manual override.
- **Multilingual.** en / de / fr / it from the start; no hardcoded user-facing strings.

## Accessibility — a strong *should*
Accessibility is **highly valued and well-supported, without being the overriding
mandate** — a should-have, not a must-have. In practice that means, by default:
- A typeface picker including **OpenDyslexic** (dyslexia) and **Atkinson Hyperlegible**
  (low vision).
- Respecting the OS text-scale; layouts that tolerate larger/wider fonts (no fixed-height
  text boxes, no truncation a bigger face would clip).
- Touch targets ≥ 48 dp; sufficient colour contrast in both themes.

It earns real effort, but a feature isn't blocked solely because the last accessibility
mile isn't paved.

## Privacy posture
- **No runtime API keys** baked into the app — nothing to leak or have revoked.
- Any optional cloud feature is **opt-in and disclosed**; data leaving the device is always
  the user's explicit, informed choice.

## Backup & device moves — the family pattern
Serverless means no sync — **by design**. Moving devices or surviving a reinstall is a
**file the user owns**: every fuchs app with meaningful state offers *Export* and *Import*
in settings. Hard-won rules (knobelfuchs + knabberfuchs, 2026-07-14 — keep them):

- **Export opens the system SAVE dialog** (SAF / document picker), never the share sheet —
  many ROMs have no save-to-file share target, and the save dialog reaches cloud providers
  anyway. Write via a **temp file + `sourceFilePath`**, not in-memory bytes.
- **Confirm with the file size** ("Sicherung gespeichert (1.2 MB).") — MIUI-style file
  managers show fresh documents as 0 bytes (stale media index); the snackbar is the
  trustworthy receipt.
- **Import picks via `flutter_file_dialog`**, which streams the copy to EOF — document
  providers report stale sizes and pickers that trust them (file_selector) deliver empty
  reads for perfectly good files. **No mime filter** on the picker (filters hide files);
  the payload validation is the gatekeeper, never the file name.
- The container is a **zip with a manifest** (app id, format/schema version): reject
  foreign files gently, **refuse backups from newer app versions** (older ones migrate
  forward), and one explicit "replace everything on this device" confirmation before
  applying. A broken optional section (e.g. settings) never blocks the core restore.

The payload strategy stays app-specific (file-level snapshot vs. logical export) — this
section pins the container and the dialogs. A shared implementation of the dialog layer
is deliberately deferred until a third app builds backup (checkfuchs), to keep this
package plugin-free meanwhile.
