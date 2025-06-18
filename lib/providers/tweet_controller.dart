import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../repository/tweet_repository.dart';
import '../state/tweet_state.dart';
import 'repository_providers.dart';
import 'tag_select_controller.dart';
import 'sort_order_provider.dart';
import 'period_filter_provider.dart';

class TweetController extends Notifier<TweetState> {
  @override
  TweetState build() {
    refresh();
    return TweetState(tweets: []);
  }

  Future refresh() async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    final tagSelectionState =
        ref.read(tagSelectControllerProvider.notifier).state;
    final period = ref.read(periodFilterProvider);
    final tags = await repository.loadTags();
    final binTag = await repository.loadTag(tagNameBin);

    var filteredIds = <String>{};
    var noFilteredIds = <String>{};
    for (var tag in tags) {
      if (tagSelectionState.selected.contains(tag.name)) {
        filteredIds.addAll(tag.tweetIds);
      } else {
        noFilteredIds.addAll(tag.tweetIds);
      }
    }

    final allTweets = await repository.loadAllTweets();
    final isSelected = tagSelectionState.selected.isNotEmpty;

    final order = ref.read(sortOrderProvider);

    var filteredTweets = <Tweet>[];
    var binnedTweets = <Tweet>[];
    for (var tweet in allTweets) {
      if (period.since != null && tweet.createdAt.isBefore(period.since!)) {
        continue;
      }
      if (period.until != null && tweet.createdAt.isAfter(period.until!)) {
        continue;
      }
      final isFilteredId = filteredIds.contains(tweet.id);
      final isNoFilteredId = noFilteredIds.contains(tweet.id);
      final isUnTaggedId = !(isFilteredId || isNoFilteredId);
      if (binTag?.tweetIds.contains(tweet.id) ?? false) {
        binnedTweets.add(tweet);
      } else if (isSelected ? isFilteredId : isUnTaggedId) {
        filteredTweets.add(tweet);
      }
    }

    int compare(Tweet a, Tweet b) =>
        order == SortOrder.newestFirst
            ? b.createdAt.compareTo(a.createdAt)
            : a.createdAt.compareTo(b.createdAt);

    filteredTweets = [...filteredTweets]..sort(compare);
    binnedTweets = [...binnedTweets]..sort(compare);

    state = TweetState(tweets: filteredTweets, binned: binnedTweets);
  }

  Future<void> addTweets(List<Tweet> tweets) async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    await repository.saveTweets(tweets);
    state = (state.copyWith(tweets: [...state.tweets, ...tweets]));
  }
}

final tweetControllerProvider = NotifierProvider<TweetController, TweetState>(
  () => TweetController(),
);
