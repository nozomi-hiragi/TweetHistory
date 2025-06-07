import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet_selection.freezed.dart';

@freezed
abstract class TweetSelectState with _$TweetSelectState {
  const factory TweetSelectState({
    @Default(false) isSelectionMode,
    @Default(<String>{}) Set<String> selectedIds,
  }) = _TweetSelectState;
}
