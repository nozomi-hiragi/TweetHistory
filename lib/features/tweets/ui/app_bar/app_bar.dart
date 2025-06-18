import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tweet_select_controller.dart';
import '../../../../common/my_search_bar.dart';
import 'apply_tag_button.dart';

class TweetsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TweetsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectModeController = ref.read(
      tweetSelectControllerProvider.notifier,
    );
    final tweetSelectState = ref.watch(tweetSelectControllerProvider);
    final isSelectionMode = tweetSelectState.isSelectionMode;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title:
          isSelectionMode
              ? Text(l10n.selectedCount(tweetSelectState.selectedIds.length))
              : const MySearchBar(),
      actions: [
        if (isSelectionMode) ApplyTagButton(),
        if (isSelectionMode)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final res = await selectModeController.setBinTag();
              final message =
                  res != null
                      ? l10n.moveToBinSuccess
                      : l10n.moveToBinError;
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: l10n.delete,
          ),
        IconButton(
          icon: Icon(isSelectionMode ? Icons.close : Icons.select_all),
          onPressed: () => selectModeController.toggle(),
          tooltip: isSelectionMode ? l10n.cancel : l10n.select,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
