// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TweetImpl _$$TweetImplFromJson(Map<String, dynamic> json) => _$TweetImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  favoriteCount: (json['favoriteCount'] as num?)?.toInt() ?? 0,
  retweetCount: (json['retweetCount'] as num?)?.toInt() ?? 0,
  inReplyToStatusId: json['inReplyToStatusId'] as String?,
  inReplyToUserId: json['inReplyToUserId'] as String?,
  inReplyToScreenName: json['inReplyToScreenName'] as String?,
  isRetweet: json['isRetweet'] as bool? ?? false,
  retweetedStatusId: json['retweetedStatusId'] as String?,
  retweetedUserScreenName: json['retweetedUserScreenName'] as String?,
  isReply: json['isReply'] as bool? ?? false,
);

Map<String, dynamic> _$$TweetImplToJson(_$TweetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'media': instance.media.map((e) => e.toJson()).toList(),
      'favoriteCount': instance.favoriteCount,
      'retweetCount': instance.retweetCount,
      'inReplyToStatusId': instance.inReplyToStatusId,
      'inReplyToUserId': instance.inReplyToUserId,
      'inReplyToScreenName': instance.inReplyToScreenName,
      'isRetweet': instance.isRetweet,
      'retweetedStatusId': instance.retweetedStatusId,
      'retweetedUserScreenName': instance.retweetedUserScreenName,
      'isReply': instance.isReply,
    };

_$MediaImpl _$$MediaImplFromJson(Map<String, dynamic> json) =>
    _$MediaImpl(url: json['url'] as String, type: json['type'] as String);

Map<String, dynamic> _$$MediaImplToJson(_$MediaImpl instance) =>
    <String, dynamic>{'url': instance.url, 'type': instance.type};
