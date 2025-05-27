import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/tweet.dart';

part 'tweet_state.freezed.dart';

@freezed
abstract class TweetState with _$TweetState {
  const factory TweetState({required List<Tweet> tweets}) = _TweetState;

  factory TweetState.empty() => const TweetState(tweets: []);
}
