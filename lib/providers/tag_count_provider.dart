import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import 'repository_providers.dart';
import 'period_filter_provider.dart';
import 'tweet_type_filter_provider.dart';

final tagCountProvider = FutureProvider<Map<String, int>>((ref) async {
  final repository = await ref.watch(tweetRepositoryProvider.future);
  final period = ref.watch(periodFilterProvider);
  final typeFilter = ref.watch(tweetTypeFilterProvider);

  final allTweets = await repository.loadAllTweets();
  final tags = await repository.loadTags();

  // Apply period and type filters to tweets
  final filteredTweets = <Tweet>[];
  for (var tweet in allTweets) {
    if (period.since != null && tweet.createdAt.isBefore(period.since!)) {
      continue;
    }
    if (period.until != null && tweet.createdAt.isAfter(period.until!)) {
      continue;
    }

    // Apply tweet type filtering
    if (typeFilter.showReplies ||
        typeFilter.showRetweets ||
        typeFilter.showRegular) {
      final isReply = tweet.isReply;
      final isRetweet = tweet.isRetweet;
      final isRegular = !isReply && !isRetweet;

      final shouldShow =
          (typeFilter.showReplies && isReply) ||
          (typeFilter.showRetweets && isRetweet) ||
          (typeFilter.showRegular && isRegular);

      if (!shouldShow) {
        continue;
      }
    }

    filteredTweets.add(tweet);
  }

  final tweetIdSet = filteredTweets.map((t) => t.id).toSet();

  // Calculate count for each tag based on filtered tweets
  final tagCounts = <String, int>{};
  for (var tag in tags) {
    final count = tag.tweetIds.where((id) => tweetIdSet.contains(id)).length;
    tagCounts[tag.name] = count;
  }

  return tagCounts;
});
