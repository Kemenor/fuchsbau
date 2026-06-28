import 'package:flutter/material.dart';

/// Fuchsbau status tokens that aren't M3 colour roles (DESIGN.md §1 status
/// colours). The triad already covers active=primary, positive/done=tertiary
/// and selection=secondary; these add the calm, non-alarming states.
///
/// Ethos: **status is information, never punishment, and red is reserved for
/// destruction only** — so an "off-target" or "attention" state is **amber**,
/// a past/missed state **fades to taupe**, never red.
@immutable
class FuchsbauStatusColors extends ThemeExtension<FuchsbauStatusColors> {
  /// Attention / nudge — information, not a command (e.g. off a target).
  final Color amber;

  /// Faded / past / missed — never red.
  final Color taupe;

  /// Neutral / declined.
  final Color neutral;

  const FuchsbauStatusColors({
    required this.amber,
    required this.taupe,
    required this.neutral,
  });

  static const light = FuchsbauStatusColors(
    amber: Color(0xFFE0A33B),
    taupe: Color(0xFFA8988C),
    neutral: Color(0xFF8C857E),
  );
  static const dark = FuchsbauStatusColors(
    amber: Color(0xFFEDB45A),
    taupe: Color(0xFFB6A79B),
    neutral: Color(0xFF9A938C),
  );

  /// The status colours from the ambient theme (falls back to [light]).
  static FuchsbauStatusColors of(BuildContext context) =>
      Theme.of(context).extension<FuchsbauStatusColors>() ?? light;

  @override
  FuchsbauStatusColors copyWith({Color? amber, Color? taupe, Color? neutral}) =>
      FuchsbauStatusColors(
        amber: amber ?? this.amber,
        taupe: taupe ?? this.taupe,
        neutral: neutral ?? this.neutral,
      );

  @override
  FuchsbauStatusColors lerp(ThemeExtension<FuchsbauStatusColors>? other, double t) {
    if (other is! FuchsbauStatusColors) return this;
    return FuchsbauStatusColors(
      amber: Color.lerp(amber, other.amber, t)!,
      taupe: Color.lerp(taupe, other.taupe, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
    );
  }
}
