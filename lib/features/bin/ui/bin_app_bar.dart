import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/tweet_select_controller.dart';
import '../../../common/my_search_bar.dart';

class BinAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BinAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final editController = ref.read(tweetSelectControllerProvider.notifier);
    final selectState = ref.watch(tweetSelectControllerProvider);
    final isEditMode = selectState.isEditMode;
    final hasSelectedTweets = isEditMode && selectState.selectedIds.isNotEmpty;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title:
          hasSelectedTweets
              ? Text(l10n.selectedCount(selectState.selectedIds.length))
              : const MySearchBar(),
      actions: [
        if (hasSelectedTweets) ...[
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final res = await editController.deleteTweets();
              final message =
                  res ? l10n.tweetsDeletedSuccess : l10n.tweetsDeletedError;
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: l10n.delete,
          ),
          IconButton(
            icon: const Icon(Icons.restore_from_trash),
            onPressed: () async {
              final res = await editController.restoreTweets();
              final message =
                  res ? l10n.tweetsRestoredSuccess : l10n.tweetsRestoredError;
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: l10n.restoreFromBin,
          ),
        ],
        IconButton(
          icon: Icon(isEditMode ? Icons.check : Icons.edit),
          onPressed: () => editController.toggleEditMode(),
          tooltip: isEditMode ? l10n.exitEditMode : l10n.editMode,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
