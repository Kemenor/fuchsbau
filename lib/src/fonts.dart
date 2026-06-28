/// The user-selectable typefaces (DESIGN.md §2). The choice is an accessibility
/// feature, not a vanity one: it only swaps the base `fontFamily`, so the M3
/// type scale stays family-agnostic. All faces are bundled in this package
/// except [system], which uses the platform default.
///
/// Pass a value to `fuchsbauTheme(brightness, font: ...)`; persist the user's
/// choice in the app and rebuild the theme on change.
enum FuchsbauFont {
  /// Figtree — the brand voice (default, friendly humanist sans).
  figtree(family: 'packages/fuchsbau/Figtree', label: 'Figtree'),

  /// The native platform font — zero bundle, maximum familiarity.
  system(family: null, label: 'System'),

  /// Atkinson Hyperlegible — accessibility for low vision; disambiguates
  /// confusable glyphs (l/I/1, O/0/Q).
  atkinsonHyperlegible(
    family: 'packages/fuchsbau/Atkinson Hyperlegible',
    label: 'Atkinson Hyperlegible',
  ),

  /// OpenDyslexic — accessibility for dyslexia; weighted letterforms.
  openDyslexic(
    family: 'packages/fuchsbau/OpenDyslexic',
    label: 'OpenDyslexic',
  );

  const FuchsbauFont({required this.family, required this.label});

  /// The Flutter `fontFamily` for this choice; `null` = platform default.
  final String? family;

  /// A human-readable name for a picker UI.
  final String label;
}
