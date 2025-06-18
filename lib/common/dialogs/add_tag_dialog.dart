import 'package:flutter/material.dart';

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
    final controller = TextEditingController();
    
    return AlertDialog(
      title: const Text('新しいタグを追加'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'タグ名'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: const Text('追加'),
        ),
      ],
    );
  }
}