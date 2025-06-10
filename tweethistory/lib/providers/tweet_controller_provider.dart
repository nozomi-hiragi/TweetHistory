import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../state/tweet_state.dart';
import 'repository_provider.dart';
import 'tag_selection_provider.dart';

class TweetControllerNotifier extends Notifier<TweetState> {
  @override
  TweetState build() {
    refresh();
    return TweetState(tweets: []);
  }

  Future refresh() async {
    final repository = ref.read(repositoryProvider).value!;
    final tagSelectionState = ref.read(tagSelectionProvider.notifier).state;
    final tags = await repository.getTags();

    var filteredIds = <String>{};
    var noFilteredIds = <String>{};
    var binnedIds = <String>{};
    for (var tag in tags) {
      if (tag.name == "bin") {
        binnedIds.addAll(tag.tweetIds);
      } else if (tagSelectionState.selected.contains(tag.name)) {
        filteredIds.addAll(tag.tweetIds);
      } else {
        noFilteredIds.addAll(tag.tweetIds);
      }
    }

    final allTweets = await repository.loadAllTweets();
    final isSelected = tagSelectionState.selected.isNotEmpty;

    var filteredTweets = <Tweet>[];
    var binnedTweets = <Tweet>[];
    for (var tweet in allTweets) {
      final isFilteredId = filteredIds.contains(tweet.id);
      final isNoFilteredId = noFilteredIds.contains(tweet.id);
      final isUnTaggedId = !(isFilteredId || isNoFilteredId);
      if (binnedIds.contains(tweet.id)) {
        binnedTweets.add(tweet);
      } else if (isSelected ? isFilteredId : isUnTaggedId) {
        filteredTweets.add(tweet);
      }
    }
    state = (TweetState(tweets: filteredTweets, binned: binnedTweets));
  }

  Future<void> addTweets(List<Tweet> tweets) async {
    final repository = ref.read(repositoryProvider).value!;
    await repository.saveTweets(tweets);
    state = (state.copyWith(tweets: [...state.tweets, ...tweets]));
  }
}

final tweetControllerProvider =
    NotifierProvider<TweetControllerNotifier, TweetState>(
      () => TweetControllerNotifier(),
    );
