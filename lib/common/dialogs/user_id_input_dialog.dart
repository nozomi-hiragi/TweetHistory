import 'package:flutter/material.dart';
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
      builder: (_) => UserIdInputDialog(
        initialValue: initialValue,
        allowEmpty: allowEmpty,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: initialValue ?? '');
    
    return AlertDialog(
      title: const Text('ユーザーID設定'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('X(Twitter)のユーザーID（@なし）を入力してください：'),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '例: https://x.com/username の場合は "username" を入力',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () {
            final value = controller.text.trim();
            if (value.isNotEmpty || allowEmpty) {
              ref.read(userIdControllerProvider.notifier)
                  .setUserId(value.isEmpty ? null : value);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value.isEmpty 
                      ? 'ユーザーIDをクリアしました' 
                      : 'ユーザーIDを設定しました'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}