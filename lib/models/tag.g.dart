// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tag _$TagFromJson(Map<String, dynamic> json) => _Tag(
  name: json['name'] as String,
  tweetIds:
      (json['tweetIds'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      const {},
);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'name': instance.name,
  'tweetIds': instance.tweetIds.toList(),
};
