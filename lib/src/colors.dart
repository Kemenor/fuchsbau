import 'package:flutter/material.dart';

/// The pinned Fuchsbau brand triad (DESIGN.md §1): a fox tangerine with two
/// **triadic** partners 120° apart on the wheel. Shared across every fuchs app
/// — apps differ by icon and content, never by palette.
///
/// These are the canonical seed hues; per-brightness on-colours and container
/// tones are derived by the theme builder (see `theme.dart`). Status colours
/// (taupe/amber/grey) are intentionally NOT here — they ride a `ThemeExtension`
/// so they can't be confused with the M3 colour roles.
class FuchsbauColors {
  const FuchsbauColors._();

  /// 26° — primary / brand / active.
  static const foxOrange = Color(0xFFEA7A24);

  /// 266° — secondary / structure / focus.
  static const indigo = Color(0xFF8559D0);

  /// 146° — tertiary / positive / done.
  static const emerald = Color(0xFF1FA85D);
}
