import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_provider.dart';
import '../../../providers/tweet_select_provider.dart';

class TweetsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TweetsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetSelectState = ref.watch(selectModeProvider);
    final selectModeController = ref.read(selectModeProvider.notifier);
    final isSelectionMode = tweetSelectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Tweets'),
      actions: [
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.bookmarks),
            onPressed: () async {
              final repository = ref.watch(repositoryProvider).value!;
              final tagNames = await repository.getTags().then(
                (tags) => tags.map((tag) => tag.name),
              );
              if (!context.mounted) return;

              final selectedTag = await showDialog<String>(
                context: context,
                builder: (context) {
                  String? tempSelectedTag;
                  return AlertDialog(
                    title: const Text('タグを選択'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView(
                        shrinkWrap: true,
                        children:
                            tagNames
                                .map(
                                  (tag) => RadioListTile<String>(
                                    title: Text(tag),
                                    value: tag,
                                    groupValue: tempSelectedTag,
                                    onChanged: (value) {
                                      tempSelectedTag = value;
                                      Navigator.of(context).pop(value);
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('キャンセル'),
                      ),
                    ],
                  );
                },
              );

              if (selectedTag != null && selectedTag.isNotEmpty) {
                final res = await selectModeController.applyTag(selectedTag);
                selectModeController.toggle();
                if (!context.mounted) return;
                final snackbar =
                    res != null
                        ? SnackBar(
                          content: Text('選択されたツイートに「$selectedTag」を付与しました。'),
                        )
                        : const SnackBar(content: Text('タグ付与に失敗しました。'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            tooltip: "振り分け",
          ),
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final res = await selectModeController.applyTag("bin");
              selectModeController.toggle();
              if (!context.mounted) return;
              final snackbar =
                  res != null
                      ? const SnackBar(content: Text('選択されたツイートを削除しました。'))
                      : const SnackBar(content: Text('削除に失敗しました。'));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
            tooltip: '削除',
          ),
        IconButton(
          icon: Icon(isSelectionMode ? Icons.close : Icons.select_all),
          onPressed: () => selectModeController.toggle(),
          tooltip: isSelectionMode ? 'キャンセル' : '選択モード',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
