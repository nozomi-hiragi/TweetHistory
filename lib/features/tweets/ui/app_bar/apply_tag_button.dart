import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/tweet_select_controller.dart';
import 'tag_select_dialog.dart';

class ApplyTagButton extends ConsumerWidget {
  const ApplyTagButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectModeController = ref.read(
      tweetSelectControllerProvider.notifier,
    );
    return IconButton(
      icon: const Icon(Icons.bookmarks),
      onPressed: () async {
        final tagStatus = await selectModeController.getTagSelectionStatus();
        if (!context.mounted) return;
        final selectedTags = await showDialog<Map<String, bool?>>(
          context: context,
          builder: (_) => TagSelectDialog(tagStatus: tagStatus),
        );
        if (selectedTags == null || selectedTags.isEmpty) return;

        final failedTags = await selectModeController.applyTags(selectedTags);
        final message =
            failedTags.isEmpty
                ? l10n.tagApplySuccess
                : l10n.tagApplyError(failedTags.join(', '));
        final snackBar = SnackBar(content: Text(message));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      tooltip: l10n.applyTag,
    );
  }
}
