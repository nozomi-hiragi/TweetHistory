import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/tag_select_controller.dart';
import '../../../providers/tweet_controller.dart';
import '../../../providers/period_filter_provider.dart';
import '../../../providers/locale_controller.dart';
import '../../../state/selected_values.dart';
import '../../../common/dialogs/add_tag_dialog.dart';

class TagFilterBar extends ConsumerWidget {
  const TagFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final periodState = ref.watch(periodFilterProvider);
    final periodController = ref.read(periodFilterProvider.notifier);
    final localeController = ref.read(localeControllerProvider.notifier);
    final currentLocale = localeController.getEffectiveLocale();
    final dateFormat = currentLocale.languageCode == 'ja' 
        ? DateFormat('yyyy年M月d日', 'ja') 
        : DateFormat('MMM d, yyyy', 'en');
    final theme = Theme.of(context);
    final hasActiveFilters =
        periodState.since != null ||
        periodState.until != null ||
        tagState.selected.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                currentLocale.languageCode == 'ja' ? 'フィルター' : 'Filters',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (hasActiveFilters)
                TextButton.icon(
                  onPressed: () {
                    periodController.setSince(null);
                    periodController.setUntil(null);
                    tagController.clearSelection();
                    tweetController.refresh();
                  },
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: Text(currentLocale.languageCode == 'ja' ? 'すべてクリア' : 'Clear All'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    textStyle: theme.textTheme.labelSmall,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentLocale.languageCode == 'ja' ? '期間' : 'Period',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildDateChip(
                    context: context,
                    theme: theme,
                    label:
                        periodState.since != null
                            ? '${currentLocale.languageCode == 'ja' ? '開始: ' : 'Since: '}${dateFormat.format(periodState.since!)}'
                            : (currentLocale.languageCode == 'ja' ? '開始日を選択' : 'Select start date'),
                    isActive: periodState.since != null,
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        locale: currentLocale,
                        initialDate: periodState.since ?? DateTime.now(),
                        firstDate: DateTime(2006),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        periodController.setSince(
                          DateTime(picked.year, picked.month, picked.day),
                        );
                        tweetController.refresh();
                      }
                    },
                    onDeleted:
                        periodState.since != null
                            ? () {
                              periodController.setSince(null);
                              tweetController.refresh();
                            }
                            : null,
                  ),
                  _buildDateChip(
                    context: context,
                    theme: theme,
                    label:
                        periodState.until != null
                            ? '${currentLocale.languageCode == 'ja' ? '終了: ' : 'Until: '}${dateFormat.format(periodState.until!)}'
                            : (currentLocale.languageCode == 'ja' ? '終了日を選択' : 'Select end date'),
                    isActive: periodState.until != null,
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        locale: currentLocale,
                        initialDate: periodState.until ?? DateTime.now(),
                        firstDate: DateTime(2006),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        periodController.setUntil(
                          DateTime(picked.year, picked.month, picked.day),
                        );
                        tweetController.refresh();
                      }
                    },
                    onDeleted:
                        periodState.until != null
                            ? () {
                              periodController.setUntil(null);
                              tweetController.refresh();
                            }
                            : null,
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                  if (tagState.selected.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        currentLocale.languageCode == 'ja' ? '${tagState.selected.length}個選択中' : '${tagState.selected.length} selected',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
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
                    return _buildTagChip(
                      context: context,
                      theme: theme,
                      tag: tag,
                      isSelected: isSelected,
                      onSelected: (_) {
                        if (isSelected) {
                          tagController.unselectTag(tag);
                        } else {
                          tagController.selectTag(tag);
                        }
                        tweetController.refresh();
                      },
                    );
                  }),
                  _buildAddTagChip(
                    context: context,
                    theme: theme,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
    VoidCallback? onDeleted,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: InputChip(
          label: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color:
                isActive
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
          avatar: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isActive 
                  ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.1)
                  : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.calendar_today,
              size: 14,
              color:
                  isActive
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onSurfaceVariant,
            ),
          ),
          backgroundColor:
              isActive
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceContainerHighest,
          selectedColor: theme.colorScheme.primaryContainer,
          onPressed: onPressed,
          onDeleted: onDeleted,
          deleteIcon:
              onDeleted != null
                  ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  )
                  : null,
          elevation: isActive ? 3 : 0,
          pressElevation: 1,
          shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
          side: BorderSide(
            color: isActive 
                ? theme.colorScheme.primary.withValues(alpha: 0.3)
                : theme.colorScheme.outline.withValues(alpha: 0.1),
            width: isActive ? 1.5 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildTagChip({
    required BuildContext context,
    required ThemeData theme,
    required String tag,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: FilterChip(
          label: Text(
            tag,
            style: theme.textTheme.labelMedium?.copyWith(
              color:
                  isSelected
                      ? theme.colorScheme.onSecondaryContainer
                      : theme.colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
          selected: isSelected,
          selectedColor: theme.colorScheme.secondaryContainer,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          checkmarkColor: theme.colorScheme.onSecondaryContainer,
          onSelected: (value) {
            // Add haptic feedback on selection
            if (Theme.of(context).platform == TargetPlatform.iOS ||
                Theme.of(context).platform == TargetPlatform.android) {
              // HapticFeedback.lightImpact(); // Uncomment if needed
            }
            onSelected(value);
          },
          showCheckmark: true,
          elevation: isSelected ? 3 : 0,
          pressElevation: 1,
          shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
          side: BorderSide(
            color: isSelected 
                ? theme.colorScheme.secondary.withValues(alpha: 0.4)
                : theme.colorScheme.outline.withValues(alpha: 0.15),
            width: isSelected ? 1.5 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildAddTagChip({
    required BuildContext context,
    required ThemeData theme,
    required Locale currentLocale,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: ActionChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.add,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                currentLocale.languageCode == 'ja' ? 'タグを追加' : 'Add Tag',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          backgroundColor: theme.colorScheme.primaryContainer.withValues(
            alpha: 0.2,
          ),
          side: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.4),
            width: 1.5,
            style: BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          pressElevation: 1,
          shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.1),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
