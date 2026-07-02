# Fuchsbau 🦊🕳️

The shared den — the **product ethos, design system, and base tech stack** every *fuchs*
app is built from. Written once here; each app inherits it and adds only its own concept
and screens, so the family stays coherent.

## Apps in the bau
- **[checkfuchs](https://github.com/Kemenor/checkfuchs)** — combined habit & to-do app.
- **[knabberfuchs](https://github.com/Kemenor/knabberfuchs)** — ad-free calorie tracker.
  *(colour being migrated from its accidental green to the shared triad)*
- *future fuchs apps inherit the same look + stack.*

## Shared vs. app-specific
| Shared (lives here) | Per-app |
|---|---|
| Brand **colours** (the triad), **fonts**, spacing/shape, iconography, component patterns | The **data model / concept** |
| Product **ethos** (local-first, ad-free, calm, dark+light, i18n) | Bespoke screens & features |
| Base **tech stack** & repo skeleton | Name, icon, store listing |

## Contents
- **[ETHOS.md](./ETHOS.md)** — product & design values
- **[DESIGN.md](./DESIGN.md)** — the design system (colours, type, spacing, components)
- **[TECH_STACK.md](./TECH_STACK.md)** — base stack, conventions, release flow

An app references this repo; its own `DESIGN_SYSTEM.md` records only **deviations** from
the bau.

## License

[Apache-2.0](./LICENSE) — Copyright 2026 Kemenor.
