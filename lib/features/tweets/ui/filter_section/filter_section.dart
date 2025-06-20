import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/tag_select_controller.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/period_filter_provider.dart';
import '../../../../providers/search_query_provider.dart';
import '../../../../providers/tweet_type_filter_provider.dart';
import '../../../../providers/repository_providers.dart';
import 'period_filter_section.dart';
import 'tag_filter_section.dart';
import 'tweet_type_filter_section.dart';

class FilterSection extends ConsumerWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final periodState = ref.watch(periodFilterProvider);
    final periodController = ref.read(periodFilterProvider.notifier);
    final typeState = ref.watch(tweetTypeFilterProvider);
    final typeController = ref.read(tweetTypeFilterProvider.notifier);
    final searchController = ref.read(searchQueryProvider.notifier);
    final theme = Theme.of(context);
    final hasActiveFilters =
        periodState.since != null ||
        periodState.until != null ||
        tagState.selected.isNotEmpty ||
        typeState.showReplies ||
        typeState.showRetweets ||
        typeState.showRegular;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
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
                l10n.filter,
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
                          ? () async {
                            // 全フィルターをクリア
                            searchController.clear();
                            periodController.setSince(null);
                            periodController.setUntil(null);
                            tagController.clearSelection();
                            typeController.clearAll();

                            // Preferencesからも削除
                            ref
                                .read(preferencesRepositoryProvider.future)
                                .then(
                                  (preference) =>
                                      preference.clearFilterSettings(),
                                );

                            tweetController.refresh();
                          }
                          : null,
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: Text(l10n.clear),
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
              TagFilterSection(),
              SizedBox(height: 16),
              TweetTypeFilterSection(),
            ],
          ),
        ],
      ),
    );
  }
}
