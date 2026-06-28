import 'package:flutter/material.dart';

/// A collapsible single-choice setting: an [ExpansionTile] (icon + title +
/// current-value subtitle) that expands to a radio list of [options]. The
/// shared shape for fuchs-app settings pickers (language, typeface, theme…),
/// so they stay visually identical across the family.
///
/// [options] maps each value to its display label, in display order.
/// [subtitles] optionally adds a helper line under specific options (e.g. an
/// accessibility note). [footnote] optionally adds muted text below the list.
class FuchsbauChoicePicker<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final T value;
  final Map<T, String> options;
  final ValueChanged<T> onChanged;
  final Map<T, String>? subtitles;
  final String? footnote;

  const FuchsbauChoicePicker({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
    this.subtitles,
    this.footnote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(options[value] ?? ''),
      children: [
        RadioGroup<T>(
          groupValue: value,
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          child: Column(
            children: [
              for (final e in options.entries)
                RadioListTile<T>(
                  value: e.key,
                  title: Text(e.value),
                  subtitle: subtitles?[e.key] == null
                      ? null
                      : Text(subtitles![e.key]!),
                ),
            ],
          ),
        ),
        if (footnote != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              footnote!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
      ],
    );
  }
}
