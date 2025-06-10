import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_provider.dart';
import '../../../providers/tweet_select_provider.dart';
import 'tag_select_dialog.dart';

class ApplyTagButton extends ConsumerWidget {
  const ApplyTagButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectModeController = ref.read(selectModeProvider.notifier);
    final repository = ref.watch(repositoryProvider).value!;
    final selectedIds = ref.read(selectModeProvider).selectedIds;
    return IconButton(
      icon: const Icon(Icons.bookmarks),
      onPressed: () async {
        final tags = await repository.getTags();
        final Map<String, bool?> tagStatus = {
          for (final tag in tags)
            tag.name:
                (() {
                  final count = selectedIds
                      .map((id) => tag.tweetIds.contains(id) ? 1 : 0)
                      .fold(0, (a, b) => a + b);
                  return count <= 0
                      ? false
                      : count >= selectedIds.length
                      ? true
                      : null;
                })(),
        };

        if (!context.mounted) return;
        final selectedTags = await showDialog<Map<String, bool?>>(
          context: context,
          builder: (context) => TagSelectDialog(tagStatus: tagStatus),
        );

        if (selectedTags != null && selectedTags.isNotEmpty) {
          final applyTagNames = <String>{};
          final removeTagNames = <String>{};
          await Future.wait(
            selectedTags.entries.map((e) async {
              if (e.value == true) {
                return selectModeController.applyTag(e.key).then((res) {
                  if (res != null) applyTagNames.add(e.key);
                });
              } else if (e.value == false) {
                return selectModeController.removeTag(e.key).then((res) {
                  if (res != null) removeTagNames.add(e.key);
                });
              }
            }),
          );

          selectModeController.toggle();
          if (!context.mounted) return;
          final message =
              '${applyTagNames.isNotEmpty ? 'タグ付与: ${applyTagNames.join(', ')}' : ''}'
              '${removeTagNames.isNotEmpty ? ' タグ削除: ${removeTagNames.join(', ')}' : ''}';
          final snackbar =
              message.isNotEmpty
                  ? SnackBar(content: Text(message))
                  : const SnackBar(content: Text('タグ付与に失敗しました。'));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      tooltip: "振り分け",
    );
  }
}
