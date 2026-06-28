# Fuchsbau — Design System

The app-agnostic look, **pinned** so the fuchs apps are visibly one family — distinguished
by icon and content, not by palette or type. Material 3, dark + light, both first-class.
Each app adds only its concept's bespoke screens; deviations go in the app's own
`DESIGN_SYSTEM.md`.

## 1. Colour — the shared triad
A fox tangerine with two **triadic** partners (120° apart on the wheel). **Pinned across
all apps.**

| Role (M3) | Name | Hue | Light | Dark |
|---|---|---|---|---|
| **primary** | Fox Orange (Tangerine) | 26° | `#EA7A24` | `#F39C4E` |
| **secondary** | Indigo | 266° | `#8559D0` | `#A98CEE` |
| **tertiary** | Emerald | 146° | `#1FA85D` | `#37CE78` |

> knabberfuchs's original green was an accident of the default M3 seed, **not a decision** —
> it's being migrated to this triad to validate the shared palette on a real device.

### Status colours
| State | Light | Dark | Treatment |
|---|---|---|---|
| Active / primary | `#EA7A24` | `#F39C4E` | orange |
| Positive / done | `#1FA85D` | `#37CE78` | emerald |
| Neutral / declined | `#8C857E` | `#9A938C` | grey |
| Faded / past | `#A8988C` | `#B6A79B` | taupe — never red |
| Attention / nudge | `#E0A33B` | `#EDB45A` | amber — *information, not command* |
| Selection / focus | `#8559D0` | `#A98CEE` | indigo |

### Red is for destruction only
Alarm red is **reserved for destructive actions** — a delete / wipe button, and
essentially nothing else. Red on "Delete" → yes. Red to signal everyday state or to nag →
never. (Status that didn't go well *fades*; it doesn't bleed.)

### Theme strategy
Anchor the three hues; build an **explicit triadic `ColorScheme`** per theme — *not*
single-seed `ColorScheme.fromSeed`, which derives secondary/tertiary from one hue and
collapses the triad. Surrounding tones come from each hue's tonal palette.

## 2. Typography — shared fonts
The **same typefaces in every app**, user-selectable for accessibility:

| Option | Role | License |
|---|---|---|
| **Figtree** | **Default** — friendly humanist sans (the brand voice) | OFL · bundled |
| **System** | native, zero bundle | — |
| **Atkinson Hyperlegible** | low-vision legibility | OFL · bundled |
| **OpenDyslexic** | dyslexia | OFL-style · bundled |

The choice swaps the base `fontFamily` only; the M3 type scale is family-agnostic.
**Tabular figures** for times / counts / streaks. Layouts must tolerate the wider faces.

**API.** All faces are bundled in this package (except System). Select one via the
`FuchsbauFont` enum and pass it to the theme builder; persist the user's choice and rebuild
the theme on change:

```dart
theme: fuchsbauTheme(Brightness.light, font: FuchsbauFont.openDyslexic),
// FuchsbauFont.values → the picker list; each has `.label` and `.family`.
```

## 3. Spacing, shape & elevation
- **Radius:** `8` chips · `12` buttons/inputs · `16` · `20` cards · `28` sheets · `full`
  pills & FAB.
- **Spacing:** `4 · 8 · 12 · 16 · 20 · 24 · 32`; screen inset `16`; FAB clearance `96`;
  list/task rows ≥ `56`.
- **Elevation — quiet:** hairline `outlineVariant` borders for separation; the **FAB is the
  only element that floats**; dark mode leans on M3 tonal surfaces over shadow.

## 4. Iconography & components
- **Material Symbols Rounded** throughout (pairs with Figtree's rounding).
- **FAB** = extended **full-pill** `+ Add`, bottom-right, primary colour, unique `heroTag`.
- **Sheets:** rounded-`28` top, drag handle, `isScrollControlled`, full-width
  `FilledButton` action at the bottom.
- **Series vs instance** edits follow the Outlook *this-occurrence / the-series* model.
- **Destructive actions are never a swipe;** swipe carries safe actions only.

## 5. Per-app specialisation
Inherit colours, fonts, scales, and patterns above. An app may add its own components and
screens; record any deviation in its own `DESIGN_SYSTEM.md`, with a pointer back here.
