import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tag_select_controller.dart';
import '../../../providers/tweet_controller.dart';
import '../../../state/selected_values.dart';

class TagFilterBar extends ConsumerWidget {
  const TagFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...tagState.values.map((tag) {
            final isSelected = tagState.selected.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (_) {
                if (isSelected) {
                  tagController.unselectTag(tag);
                } else {
                  tagController.selectTag(tag);
                }
                tweetController.refresh();
              },
            );
          }),
          ActionChip(
            label: const Icon(Icons.add),
            tooltip: "Add tag",
            onPressed: () async {
              final controller = TextEditingController();
              final newTag = await showDialog<String>(
                context: context,
                builder:
                    (context) => AlertDialog(
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
                          onPressed:
                              () => Navigator.of(
                                context,
                              ).pop(controller.text.trim()),
                          child: const Text('追加'),
                        ),
                      ],
                    ),
              );
              if (newTag != null && newTag.isNotEmpty) {
                tagController.addTag(newTag);
              }
            },
          ),
        ],
      ),
    );
  }
}
