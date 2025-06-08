import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tweet.dart';
import '../state/tweet_state.dart';
import 'repository_provider.dart';

class TweetControllerNotifier extends Notifier<TweetState> {
  @override
  TweetState build() {
    refresh();
    return TweetState(tweets: []);
  }

  Future refresh() async {
    final repository = ref.read(repositoryProvider).value!;
    final allTweets = await repository.loadAllTweets();
    final binTag = await repository.getTag("bin");
    final binnedIds = binTag?.tweetIds ?? <String>{};

    var filteredTweets = <Tweet>[];
    var binnedTweets = <Tweet>[];

    for (var tweet in allTweets) {
      if (binnedIds.contains(tweet.id)) {
        binnedTweets.add(tweet);
      } else {
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
