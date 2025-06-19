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
    final editModeController = ref.read(tweetSelectControllerProvider.notifier);
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
          ApplyTagButton(),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final res = await editModeController.setBinTag();
              final message =
                  res != null ? l10n.moveToBinSuccess : l10n.moveToBinError;
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            tooltip: l10n.delete,
          ),
        ],
        IconButton(
          icon: Icon(isEditMode ? Icons.check : Icons.edit),
          onPressed: () => editModeController.toggleEditMode(),
          tooltip: isEditMode ? l10n.exitEditMode : l10n.editMode,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
