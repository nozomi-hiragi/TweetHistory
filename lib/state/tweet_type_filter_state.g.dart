// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_type_filter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TweetTypeFilterState _$TweetTypeFilterStateFromJson(
  Map<String, dynamic> json,
) => _TweetTypeFilterState(
  showReplies: json['showReplies'] as bool? ?? false,
  showRetweets: json['showRetweets'] as bool? ?? false,
  showRegular: json['showRegular'] as bool? ?? false,
);

Map<String, dynamic> _$TweetTypeFilterStateToJson(
  _TweetTypeFilterState instance,
) => <String, dynamic>{
  'showReplies': instance.showReplies,
  'showRetweets': instance.showRetweets,
  'showRegular': instance.showRegular,
};
