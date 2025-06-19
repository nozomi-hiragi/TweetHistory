import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tag_select_controller.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/tweet_select_controller.dart';
import '../../../../providers/repository_providers.dart';
import '../../../../state/selected_values.dart';
import '../../../../common/dialogs/add_tag_dialog.dart';
import '../../../../common/dialogs/rename_tag_dialog.dart';
import '../../../../common/dialogs/delete_tag_dialog.dart';
import '../../../../repository/tweet_repository.dart';
import 'tag_chip.dart';
import 'add_tag_chip.dart';

class TagFilterSection extends ConsumerWidget {
  const TagFilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final selectionState = ref.watch(tweetSelectControllerProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.tagsLabel,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Opacity(
              opacity: tagState.selected.isNotEmpty ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.countSelected(tagState.selected.length),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            ...tagState.values.map((tag) {
              final isSelected = tagState.selected.contains(tag);
              return TagChip(
                tag: tag,
                isSelected: isSelected,
                isEditMode: selectionState.isEditMode,
                onSelected:
                    selectionState.isEditMode
                        ? null
                        : (_) {
                          (isSelected
                              ? tagController.unselectTag
                              : tagController.selectTag)(tag);
                          tweetController.refresh();
                        },
                onRename:
                    selectionState.isEditMode
                        ? () => _handleRenameTag(context, ref, tag)
                        : null,
                onDelete:
                    selectionState.isEditMode
                        ? () => _handleDeleteTag(context, ref, tag)
                        : null,
              );
            }),
            if (!selectionState.isEditMode)
              AddTagChip(
                onPressed: () async {
                  final newTag = await AddTagDialog.show(context);
                  if (newTag != null && newTag.isNotEmpty) {
                    tagController.addTag(newTag);
                  }
                },
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleRenameTag(
    BuildContext context,
    WidgetRef ref,
    String tagName,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    // Cannot rename system tags
    if (tagName == tagNameBin) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.cannotDeleteSystemTag)));
      return;
    }

    final newTagName = await RenameTagDialog.show(context, tagName);
    if (newTagName == null || newTagName.trim().isEmpty) return;

    final repository = await ref.read(tweetRepositoryProvider.future);
    final success = await repository.renameTag(tagName, newTagName.trim());

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.tagRenamedSuccess(newTagName.trim()))),
      );
      // Refresh the tag list and tweets
      ref.read(tagSelectControllerProvider.notifier).refresh();
      ref.read(tweetControllerProvider.notifier).refresh();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tagRenameError)));
    }
  }

  Future<void> _handleDeleteTag(
    BuildContext context,
    WidgetRef ref,
    String tagName,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    // Cannot delete system tags
    if (tagName == tagNameBin) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.cannotDeleteSystemTag)));
      return;
    }

    final confirmed = await DeleteTagDialog.show(context, tagName);
    if (confirmed != true) return;

    final repository = await ref.read(tweetRepositoryProvider.future);
    final success = await repository.deleteTag(tagName);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tagDeletedSuccess(tagName))));
      // Refresh the tag list and tweets
      ref.read(tagSelectControllerProvider.notifier).refresh();
      ref.read(tweetControllerProvider.notifier).refresh();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tagDeleteError)));
    }
  }
}
