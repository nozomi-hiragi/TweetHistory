import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_select_controller.dart';
import '../../../common/my_search_bar.dart';

class BinAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BinAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectController = ref.read(tweetSelectControllerProvider.notifier);
    final selectState = ref.watch(tweetSelectControllerProvider);
    final isSelectionMode = selectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title:
          isSelectionMode
              ? Text(l10n.selectedCount(selectState.selectedIds.length))
              : const MySearchBar(),
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
            tooltip: l10n.delete,
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
            tooltip: l10n.restoreFromBin,
          ),
        IconButton(
          icon: Icon(isSelectionMode ? Icons.close : Icons.select_all),
          onPressed: () => selectController.toggle(),
          tooltip: isSelectionMode ? l10n.cancel : l10n.select,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
