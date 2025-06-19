import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteTagDialog extends StatelessWidget {
  const DeleteTagDialog({
    super.key,
    required this.tagName,
  });

  final String tagName;

  static Future<bool?> show(
    BuildContext context,
    String tagName,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteTagDialog(tagName: tagName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(l10n.deleteTagTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.deleteTagWarning(tagName)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          child: Text(l10n.delete),
        ),
      ],
    );
  }
}