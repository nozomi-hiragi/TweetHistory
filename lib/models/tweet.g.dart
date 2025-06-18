// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tweet _$TweetFromJson(Map<String, dynamic> json) => _Tweet(
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
);

Map<String, dynamic> _$TweetToJson(_Tweet instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'media': instance.media.map((e) => e.toJson()).toList(),
  'favoriteCount': instance.favoriteCount,
  'retweetCount': instance.retweetCount,
};

_Media _$MediaFromJson(Map<String, dynamic> json) =>
    _Media(url: json['url'] as String, type: json['type'] as String);

Map<String, dynamic> _$MediaToJson(_Media instance) => <String, dynamic>{
  'url': instance.url,
  'type': instance.type,
};
