import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tag_select_controller.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/period_filter_provider.dart';
import '../../../../providers/locale_controller.dart';
import 'period_filter_section.dart';

class FilterSection extends ConsumerWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final periodState = ref.watch(periodFilterProvider);
    final periodController = ref.read(periodFilterProvider.notifier);
    final localeController = ref.read(localeControllerProvider.notifier);
    final currentLocale = localeController.getEffectiveLocale();
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
              Opacity(
                opacity: hasActiveFilters ? 1.0 : 0.0,
                child: TextButton.icon(
                  onPressed:
                      hasActiveFilters
                          ? () {
                            periodController.setSince(null);
                            periodController.setUntil(null);
                            tagController.clearSelection();
                            tweetController.refresh();
                          }
                          : null,
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: Text(
                    currentLocale.languageCode == 'ja' ? 'すべてクリア' : 'Clear All',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    textStyle: theme.textTheme.labelSmall,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PeriodFilterSection(),
              SizedBox(height: 16),
              FilterSection(),
            ],
          ),
        ],
      ),
    );
  }
}
