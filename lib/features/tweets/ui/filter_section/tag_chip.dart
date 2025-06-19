import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final bool isEditMode;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;

  const TagChip({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.onSelected,
    this.isEditMode = false,
    this.onRename,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(
        tag,
        style: theme.textTheme.labelMedium?.copyWith(
          color:
              isSelected
                  ? theme.colorScheme.onSecondaryContainer
                  : theme.colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      selected: isSelected,
      showCheckmark: true,
      side: BorderSide(
        color:
            isSelected
                ? theme.colorScheme.secondary.withValues(alpha: 0.4)
                : theme.colorScheme.outline.withValues(alpha: 0.15),
        width: isSelected ? 1.5 : 1,
      ),
      visualDensity: VisualDensity.compact,
      onSelected: (v) => isEditMode ? onRename?.call() : onSelected?.call(v),
      onDeleted: isEditMode ? onDelete : null,
    );
  }
}
