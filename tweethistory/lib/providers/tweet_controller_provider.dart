import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tweet.dart';
import '../state/tweet_state.dart';
import 'repository_provider.dart';

class TweetControllerNotifier extends Notifier<TweetState> {
  @override
  TweetState build() {
    final repository = ref.read(repositoryProvider).value!;
    repository.loadAllTweets().then((tweets) {
      state = (TweetState(tweets: tweets));
    });
    return TweetState(tweets: []);
  }

  Future<void> addTweets(List<Tweet> tweets) async {
    final repository = ref.read(repositoryProvider).value!;
    await repository.saveTweets(tweets);
    state = (state.copyWith(tweets: [...state.tweets, ...tweets]));
  }

  Future<void> removeTweet(String id) async {
    final repository = ref.read(repositoryProvider).value!;
    await repository.deleteTweet(id);
    state = state.copyWith(
      tweets: state.tweets.where((t) => t.id != id).toList(),
    );
  }
}

final tweetControllerProvider =
    NotifierProvider<TweetControllerNotifier, TweetState>(
      () => TweetControllerNotifier(),
    );
