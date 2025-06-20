import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AddTagDialog extends StatelessWidget {
  const AddTagDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (_) => const AddTagDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    
    return AlertDialog(
      title: Text(l10n.addNewTag),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(hintText: l10n.tagNamePlaceholder),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(l10n.add),
        ),
      ],
    );
  }
}