import 'package:flutter/material.dart';

import 'colors.dart';
import 'status_colors.dart';

/// Per-brightness surface + brand tokens — the *exact* values the design canon
/// (examples/ui) uses. We deliberately do NOT let `ColorScheme.fromSeed` tone
/// these: its tonal algorithm mutes and greys the brand hues (FABs go dull, the
/// triad collapses). DESIGN.md §1 calls for an explicit triad, so these land
/// verbatim on the colour roles; fromSeed is used only as a base to fill the
/// roles we don't hand-pick (error, shadow, inverse…).
class _Tokens {
  final Color bg, card, line, ink, muted, orange, indigo, emerald, onBrand;
  const _Tokens({
    required this.bg,
    required this.card,
    required this.line,
    required this.ink,
    required this.muted,
    required this.orange,
    required this.indigo,
    required this.emerald,
    required this.onBrand,
  });
}

const _light = _Tokens(
  bg: Color(0xFFFDF6F1), // warm tangerine-tinted surface
  card: Color(0xFFFFFFFF), // crisp white card / sheet / nav
  line: Color(0xFFF0E2D8), // hairline outlineVariant
  ink: Color(0xFF231B16),
  muted: Color(0xFF8A7B70),
  orange: FuchsbauColors.foxOrange, // 0xFFEA7A24
  indigo: FuchsbauColors.indigo, //    0xFF8559D0
  emerald: FuchsbauColors.emerald, //  0xFF1FA85D
  onBrand: Color(0xFFFFFFFF),
);
const _dark = _Tokens(
  bg: Color(0xFF16110D),
  card: Color(0xFF211A15),
  line: Color(0xFF332821),
  ink: Color(0xFFF3EDE9),
  muted: Color(0xFFA99E96),
  orange: Color(0xFFF39C4E),
  indigo: Color(0xFFA98CEE),
  emerald: Color(0xFF37CE78),
  onBrand: Color(0xFF121009), // dark text on the brighter dark-mode brand fills
);

_Tokens _tokensFor(Brightness b) => b == Brightness.light ? _light : _dark;

Color _mix(Color c, double a, Color base) =>
    Color.alphaBlend(c.withValues(alpha: a), base);

/// The shared Fuchsbau [ColorScheme] for a [brightness] — the exact triad
/// (fox orange · indigo · emerald) on clean white/warm surfaces, not the muted
/// fromSeed derivation.
ColorScheme fuchsbauColorScheme(Brightness brightness) {
  final t = _tokensFor(brightness);
  // fromSeed only supplies the roles we don't override (error/shadow/inverse).
  final base = ColorScheme.fromSeed(seedColor: t.orange, brightness: brightness);
  return base.copyWith(
    primary: t.orange,
    onPrimary: t.onBrand,
    primaryContainer: _mix(t.orange, .16, t.card),
    onPrimaryContainer: t.ink,
    secondary: t.indigo,
    onSecondary: t.onBrand,
    secondaryContainer: _mix(t.indigo, .22, t.card), // nav pill / structural tint
    onSecondaryContainer: t.indigo,
    tertiary: t.emerald,
    onTertiary: t.onBrand,
    tertiaryContainer: _mix(t.emerald, .16, t.card), // target band
    onTertiaryContainer: t.ink,
    surface: t.bg,
    onSurface: t.ink,
    onSurfaceVariant: t.muted,
    outline: t.muted,
    outlineVariant: t.line,
    // Two-surface model: everything raised (card / sheet / dialog / nav) = card.
    surfaceContainerLowest: t.card,
    surfaceContainerLow: t.card,
    surfaceContainer: t.card,
    surfaceContainerHigh: t.card,
    surfaceContainerHighest: t.card,
  );
}

/// The shared Fuchsbau [ThemeData] for a [brightness].
///
/// Carries the cross-app design tokens (DESIGN.md §3–4): quiet elevation
/// (hairline borders, no shadow — the FAB is the only float), soft rounding
/// (cards lg-20, FAB full pill, sheets xl-28), white card / sheet / nav on the
/// warm surface. Apps layer bespoke component themes on top.
ThemeData fuchsbauTheme(Brightness brightness) {
  final t = _tokensFor(brightness);
  final scheme = fuchsbauColorScheme(brightness);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    extensions: [
      brightness == Brightness.light
          ? FuchsbauStatusColors.light
          : FuchsbauStatusColors.dark,
    ],
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    // DESIGN.md §3: crisp card, flat, soft lg(20) rounding, hairline border.
    cardTheme: CardThemeData(
      elevation: 0,
      color: t.card,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    // DESIGN.md §3: nav is a clean white (card) bar with a hairline top border;
    // the selected destination is the indigo focus pill.
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: t.card,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.secondaryContainer,
    ),
    // DESIGN.md §4: sheets get the xl(28) top rounding.
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: t.card,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    // DESIGN.md §4: the FAB is a full-pill (family default colour = primary).
    // Per-app colour application (e.g. knabberfuchs's emerald CTA) is layered
    // on in the app's own theme, not here.
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(),
    ),
  );
}
