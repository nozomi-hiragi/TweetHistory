import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_select_controller.dart';
import '../../../providers/search_query_provider.dart';
import '../../../common/search_bar.dart';

class BinAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BinAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectController = ref.read(tweetSelectControllerProvider.notifier);
    final selectState = ref.watch(tweetSelectControllerProvider);
    final isSelectionMode = selectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: isSelectionMode
          ? Text('${selectState.selectedIds.length}件選択中')
          : const SearchBar(),
      actions: [
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final res = await selectController.deleteTweets();
              final message = res ? '選択されたツイートを削除しました。' : 'ツイートを削除できませんでした。';
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: '削除',
          ),
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.restore_from_trash),
            onPressed: () async {
              final res = await selectController.restoreTweets();
              final message = res ? '選択されたツイートを戻しました。' : 'ツイートを戻せませんでした。';
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: '戻す',
          ),
        IconButton(
          icon: Icon(isSelectionMode ? Icons.close : Icons.select_all),
          onPressed: () => selectController.toggle(),
          tooltip: isSelectionMode ? 'キャンセル' : '選択モード',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
