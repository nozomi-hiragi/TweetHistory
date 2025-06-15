import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tweet_select_controller.dart';
import '../../../../common/my_search_bar.dart';
import 'apply_tag_button.dart';

class TweetsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TweetsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectModeController = ref.read(
      tweetSelectControllerProvider.notifier,
    );
    final tweetSelectState = ref.watch(tweetSelectControllerProvider);
    final isSelectionMode = tweetSelectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: isSelectionMode
          ? Text('${tweetSelectState.selectedIds.length}件選択中')
          : const MySearchBar(),
      actions: [
        if (isSelectionMode) ApplyTagButton(),
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final res = await selectModeController.setBinTag();
              final message = res != null
                  ? '選択されたツイートをゴミ箱に移動しました。'
                  : 'ゴミ箱に移動できませんでした。';
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
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
