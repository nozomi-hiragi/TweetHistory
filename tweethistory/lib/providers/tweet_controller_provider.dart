import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tweet.dart';
import '../state/tweet_state.dart';
import '../repository/tweet_repository.dart';

class TweetControllerNotifier extends AsyncNotifier<TweetState> {
  final TweetRepository _repository = TweetRepository();

  @override
  Future<TweetState> build() async {
    await _repository.init();
    final loadedTweets = await _repository.loadAllTweets();
    return loadedTweets.isNotEmpty
        ? TweetState(tweets: loadedTweets)
        : TweetState.empty();
  }

  void addTweets(List<Tweet> tweets) => state.when(
    data: (data) async {
      await _repository.saveTweets(tweets);
      state = AsyncData(data.copyWith(tweets: [...data.tweets, ...tweets]));
    },
    error: (error, stack) {},
    loading: () {},
  );

  void removeTweet(String id) => state.when(
    data: (data) async {
      await _repository.deleteTweet(id);
      state = AsyncData(
        data.copyWith(tweets: data.tweets.where((t) => t.id != id).toList()),
      );
    },
    error: (error, stack) {},
    loading: () {},
  );
}

final tweetControllerProvider =
    AsyncNotifierProvider<TweetControllerNotifier, TweetState>(
      () => TweetControllerNotifier(),
    );
