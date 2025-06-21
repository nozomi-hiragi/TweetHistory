import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/tweet_select_controller.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/search_query_provider.dart';
import '../../../../providers/tag_select_controller.dart';
import '../../../../providers/period_filter_provider.dart';
import '../../../../providers/tweet_type_filter_provider.dart';
import '../../../../common/my_search_bar.dart';
import '../../../../common/dialogs/llm_rating_confirm_dialog.dart';
import '../../../../common/dialogs/llm_rating_progress_dialog.dart';
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
        if (!isEditMode && !kIsWeb)
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/llm_rating.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                IconTheme.of(context).color ??
                    Theme.of(context).appBarTheme.iconTheme?.color ??
                    Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => _showLlmRatingDialog(context, ref),
            tooltip: l10n.llmRating,
          ),
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

  List<dynamic> _getFilteredTweets(WidgetRef ref) {
    final tweetState = ref.read(tweetControllerProvider);
    final query = ref.read(searchQueryProvider);

    // 検索クエリでさらにフィルタリング
    return query.isEmpty
        ? tweetState.tweets
        : tweetState.tweets
            .where((t) => t.text.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  String _getFilterDescription(WidgetRef ref, AppLocalizations l10n) {
    final query = ref.read(searchQueryProvider);
    final tagSelection = ref.read(tagSelectControllerProvider);
    final periodFilter = ref.read(periodFilterProvider);
    final typeFilter = ref.read(tweetTypeFilterProvider);

    final filterParts = <String>[];

    if (query.isNotEmpty) {
      filterParts.add(l10n.filterSearch(query));
    }

    if (tagSelection.selected.isNotEmpty) {
      filterParts.add(l10n.filterTags(tagSelection.selected.join(", ")));
    }

    if (periodFilter.since != null || periodFilter.until != null) {
      final since =
          periodFilter.since?.toString().substring(0, 10) ?? l10n.periodStart;
      final until =
          periodFilter.until?.toString().substring(0, 10) ?? l10n.periodEnd;
      filterParts.add(l10n.filterPeriod(since, until));
    }

    if (typeFilter.showReplies ||
        typeFilter.showRetweets ||
        typeFilter.showRegular) {
      final types = <String>[];
      if (typeFilter.showRegular) types.add(l10n.tweetTypeRegular);
      if (typeFilter.showReplies) types.add(l10n.tweetTypeReply);
      if (typeFilter.showRetweets) types.add(l10n.tweetTypeRetweet);
      filterParts.add(l10n.filterTypes(types.join(", ")));
    }

    return filterParts.isEmpty ? l10n.noFilters : filterParts.join('\n');
  }

  Future<void> _showLlmRatingDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final tweets = _getFilteredTweets(ref);
    final filterDescription = _getFilterDescription(ref, l10n);

    if (tweets.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.noTweetsToRate)));
      return;
    }

    final confirmed = await LlmRatingConfirmDialog.show(
      context,
      tweetCount: tweets.length,
      filterDescription: filterDescription,
    );

    if (confirmed != true) return;

    if (!context.mounted) return;
    LlmRatingProgressDialog.show(context, tweets: tweets);
  }
}
