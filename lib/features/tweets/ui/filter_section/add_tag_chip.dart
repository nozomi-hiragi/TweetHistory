import 'package:flutter/material.dart';

class AddTagChip extends StatelessWidget {
  final Locale currentLocale;
  final VoidCallback onPressed;

  const AddTagChip({
    super.key,
    required this.currentLocale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 18),
          const SizedBox(width: 6),
          Text(
            currentLocale.languageCode == 'ja' ? 'タグを追加' : 'Add Tag',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
      side: BorderSide(
        color: theme.colorScheme.primary.withValues(alpha: 0.4),
        width: 1.5,
        style: BorderStyle.solid,
      ),
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
    );
  }
}
