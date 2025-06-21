import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final bool isEditMode;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;
  final int? count;

  const TagChip({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.onSelected,
    this.isEditMode = false,
    this.onRename,
    this.onDelete,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
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
          if (count != null) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? theme.colorScheme.onSecondaryContainer.withValues(
                          alpha: 0.2,
                        )
                        : theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.15,
                        ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count.toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color:
                      isSelected
                          ? theme.colorScheme.onSecondaryContainer
                          : theme.colorScheme.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
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
