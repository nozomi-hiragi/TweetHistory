import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tweet.dart';

class TweetNotifier extends StateNotifier<List<Tweet>> {
  TweetNotifier() : super([]);

  void addTweet(Tweet tweet) {
    state = [...state, tweet];
  }

  void addAll(List<Tweet> tweets) {
    state = [...state, ...tweets];
  }

  void removeTweet(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void clearAll() {
    state = [];
  }
}

final tweetProvider = StateNotifierProvider<TweetNotifier, List<Tweet>>((ref) {
  return TweetNotifier();
});
