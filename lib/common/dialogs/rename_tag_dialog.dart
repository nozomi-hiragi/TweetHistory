import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RenameTagDialog extends HookWidget {
  const RenameTagDialog({
    super.key,
    required this.originalTagName,
  });

  final String originalTagName;

  static Future<String?> show(
    BuildContext context,
    String originalTagName,
  ) async {
    return showDialog<String>(
      context: context,
      builder: (context) => RenameTagDialog(originalTagName: originalTagName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = useTextEditingController(text: originalTagName);
    final errorMessage = useState<String?>(null);

    return AlertDialog(
      title: Text(l10n.renameTagTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: l10n.newTagName,
              hintText: l10n.tagNamePlaceholder,
              errorText: errorMessage.value,
            ),
            autofocus: true,
            onSubmitted: (value) {
              final tagName = value.trim();
              if (tagName.isEmpty) {
                errorMessage.value = l10n.invalidTagName;
                return;
              }
              if (tagName == originalTagName) {
                Navigator.of(context).pop();
                return;
              }
              Navigator.of(context).pop(tagName);
            },
            onChanged: (value) {
              if (errorMessage.value != null) {
                errorMessage.value = null;
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final tagName = controller.text.trim();
            if (tagName.isEmpty) {
              errorMessage.value = l10n.invalidTagName;
              return;
            }
            if (tagName == originalTagName) {
              Navigator.of(context).pop();
              return;
            }
            Navigator.of(context).pop(tagName);
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}