import 'package:flutter/material.dart';

class DateChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final VoidCallback? onDeleted;

  const DateChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InputChip(
      label: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      avatar: Icon(Icons.calendar_today, size: 14),
      backgroundColor:
          isActive
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
      side: BorderSide(
        color:
            isActive
                ? theme.colorScheme.primary.withValues(alpha: 0.3)
                : theme.colorScheme.outline.withValues(alpha: 0.1),
        width: isActive ? 1.5 : 1,
      ),
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      onDeleted: onDeleted,
    );
  }
}
