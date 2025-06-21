// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_type_filter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TweetTypeFilterStateImpl _$$TweetTypeFilterStateImplFromJson(
  Map<String, dynamic> json,
) => _$TweetTypeFilterStateImpl(
  showReplies: json['showReplies'] as bool? ?? false,
  showRetweets: json['showRetweets'] as bool? ?? false,
  showRegular: json['showRegular'] as bool? ?? false,
);

Map<String, dynamic> _$$TweetTypeFilterStateImplToJson(
  _$TweetTypeFilterStateImpl instance,
) => <String, dynamic>{
  'showReplies': instance.showReplies,
  'showRetweets': instance.showRetweets,
  'showRegular': instance.showRegular,
};
