import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet_type_filter_state.freezed.dart';
part 'tweet_type_filter_state.g.dart';

@freezed
abstract class TweetTypeFilterState with _$TweetTypeFilterState {
  const factory TweetTypeFilterState({
    @Default(false) bool showReplies,
    @Default(false) bool showRetweets,
    @Default(false) bool showRegular,
  }) = _TweetTypeFilterState;

  factory TweetTypeFilterState.fromJson(Map<String, dynamic> json) =>
      _$TweetTypeFilterStateFromJson(json);
}