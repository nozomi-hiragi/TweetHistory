import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/user_id_controller.dart';

class UserIdInputDialog extends ConsumerWidget {
  const UserIdInputDialog({
    super.key,
    this.initialValue,
    this.allowEmpty = true,
  });

  final String? initialValue;
  final bool allowEmpty;

  static Future<void> show(
    BuildContext context, {
    String? initialValue,
    bool allowEmpty = true,
  }) {
    return showDialog(
      context: context,
      builder:
          (_) => UserIdInputDialog(
            initialValue: initialValue,
            allowEmpty: allowEmpty,
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: initialValue ?? '');
    return AlertDialog(
      title: Text(l10n.userIdSetting),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.userIdDescription),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: l10n.userIdPlaceholder,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.userIdExample,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () {
            final value = controller.text.trim();
            if (value.isNotEmpty || allowEmpty) {
              ref
                  .read(userIdControllerProvider.notifier)
                  .setUserId(value.isEmpty ? null : value);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value.isEmpty ? l10n.userIdCleared : l10n.userIdSet,
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
