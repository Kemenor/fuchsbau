import 'package:flutter/material.dart';

/// The shared settings-screen anatomy for the fuchs family: uppercase
/// [FuchsbauSectionHeader]s outside white [FuchsbauSettingsCard]s that group
/// the rows with hairline dividers. Extracted from knabberfuchs/checkfuchs so
/// every app's Settings reads identically.

/// Row inset inside a [FuchsbauSettingsCard] — pass as a tile's
/// `contentPadding` (or `tilePadding` for expansion tiles).
const fuchsbauCardRowPadding = EdgeInsets.symmetric(horizontal: 12);

/// Groups a section's rows inside a single [Card], inserting a hairline
/// divider between consecutive rows. Card fill/border/radius come from the
/// theme — do not override them here.
class FuchsbauSettingsCard extends StatelessWidget {
  final List<Widget> children;
  const FuchsbauSettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        rows.add(const Divider(height: 1, indent: 16, endIndent: 16));
      }
      rows.add(children[i]);
    }
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(children: rows),
    );
  }
}

/// Uppercase muted section label above a [FuchsbauSettingsCard], announced as
/// a header to screen readers.
class FuchsbauSectionHeader extends StatelessWidget {
  final String title;
  const FuchsbauSectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Semantics(
        header: true,
        child: Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
