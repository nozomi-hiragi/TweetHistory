import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/tweet.dart';

part 'tweet_loader_state.freezed.dart';

@freezed
abstract class TweetLoaderState with _$TweetLoaderState {
  const factory TweetLoaderState({
    @Default(0.0) double progress,
    @Default([]) List<Tweet> tweets,
    String? error,
  }) = _TweetLoaderState;
}
