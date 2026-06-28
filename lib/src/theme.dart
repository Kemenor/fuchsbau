import 'package:flutter/material.dart';

import 'colors.dart';

/// Builds the shared Fuchsbau [ColorScheme] for a [brightness].
///
/// DESIGN.md §1 is explicit: do **not** use a single-seed
/// `ColorScheme.fromSeed`, which derives secondary/tertiary from one hue and
/// collapses the triad. Instead we seed three schemes — one per brand hue — and
/// graft indigo onto `secondary` and emerald onto `tertiary`, so each role keeps
/// a tonally-correct container / on-colour set in both light and dark.
ColorScheme fuchsbauColorScheme(Brightness brightness) {
  final base = ColorScheme.fromSeed(
    seedColor: FuchsbauColors.foxOrange,
    brightness: brightness,
  );
  final indigo = ColorScheme.fromSeed(
    seedColor: FuchsbauColors.indigo,
    brightness: brightness,
  );
  final emerald = ColorScheme.fromSeed(
    seedColor: FuchsbauColors.emerald,
    brightness: brightness,
  );
  return base.copyWith(
    secondary: indigo.primary,
    onSecondary: indigo.onPrimary,
    secondaryContainer: indigo.primaryContainer,
    onSecondaryContainer: indigo.onPrimaryContainer,
    tertiary: emerald.primary,
    onTertiary: emerald.onPrimary,
    tertiaryContainer: emerald.primaryContainer,
    onTertiaryContainer: emerald.onPrimaryContainer,
  );
}

/// The shared Fuchsbau [ThemeData] for a [brightness].
///
/// Carries the cross-app design tokens (DESIGN.md §3–4): quiet elevation, soft
/// rounding (cards lg-20, FAB full pill). Apps layer their own bespoke
/// component themes on top and record deviations in their own DESIGN_SYSTEM.md.
ThemeData fuchsbauTheme(Brightness brightness) {
  final scheme = fuchsbauColorScheme(brightness);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    // DESIGN.md §3: cards are flat with soft lg(20) rounding.
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
