// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
  name: json['name'] as String,
  tweetIds:
      (json['tweetIds'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      const {},
);

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
  'name': instance.name,
  'tweetIds': instance.tweetIds.toList(),
};
