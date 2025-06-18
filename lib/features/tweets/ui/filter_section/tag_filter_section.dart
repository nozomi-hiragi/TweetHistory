import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tag_select_controller.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/locale_controller.dart';
import '../../../../state/selected_values.dart';
import '../../../../common/dialogs/add_tag_dialog.dart';
import 'tag_chip.dart';
import 'add_tag_chip.dart';

class TagFilterSection extends ConsumerWidget {
  const TagFilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final localeController = ref.read(localeControllerProvider.notifier);
    final currentLocale = localeController.getEffectiveLocale();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              currentLocale.languageCode == 'ja' ? 'タグ' : 'Tags',
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
                  currentLocale.languageCode == 'ja'
                      ? '${tagState.selected.length}個選択中'
                      : '${tagState.selected.length} selected',
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
                onSelected: (_) {
                  (isSelected
                      ? tagController.unselectTag
                      : tagController.selectTag)(tag);
                  tweetController.refresh();
                },
              );
            }),
            AddTagChip(
              currentLocale: currentLocale,
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
}
