import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class AddTagChip extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTagChip({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 18),
          const SizedBox(width: 6),
          Text(
            l10n.addTag,
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
