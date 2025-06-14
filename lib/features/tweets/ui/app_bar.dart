import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_select_provider.dart';
import 'apply_tag_button.dart';

class TweetsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TweetsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectModeController = ref.read(selectModeProvider.notifier);
    final tweetSelectState = ref.watch(selectModeProvider);
    final isSelectionMode = tweetSelectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Tweets'),
      actions: [
        if (isSelectionMode) ApplyTagButton(),
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final res = await selectModeController.setBinTag();
              if (!context.mounted) return;
              final snackbar =
                  res != null
                      ? const SnackBar(content: Text('選択されたツイートをゴミ箱に移動しました。'))
                      : const SnackBar(content: Text('ゴミ箱に移動できませんでした。'));
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
