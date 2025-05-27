// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tweet {

 String get id; String get text; DateTime get createdAt; List<Media> get media;
/// Create a copy of Tweet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetCopyWith<Tweet> get copyWith => _$TweetCopyWithImpl<Tweet>(this as Tweet, _$identity);

  /// Serializes this Tweet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tweet&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.media, media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt,const DeepCollectionEquality().hash(media));

@override
String toString() {
  return 'Tweet(id: $id, text: $text, createdAt: $createdAt, media: $media)';
}


}

/// @nodoc
abstract mixin class $TweetCopyWith<$Res>  {
  factory $TweetCopyWith(Tweet value, $Res Function(Tweet) _then) = _$TweetCopyWithImpl;
@useResult
$Res call({
 String id, String text, DateTime createdAt, List<Media> media
});




}
/// @nodoc
class _$TweetCopyWithImpl<$Res>
    implements $TweetCopyWith<$Res> {
  _$TweetCopyWithImpl(this._self, this._then);

  final Tweet _self;
  final $Res Function(Tweet) _then;

/// Create a copy of Tweet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? createdAt = null,Object? media = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tweet implements Tweet {
  const _Tweet({required this.id, required this.text, required this.createdAt, final  List<Media> media = const []}): _media = media;
  factory _Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);

@override final  String id;
@override final  String text;
@override final  DateTime createdAt;
 final  List<Media> _media;
@override@JsonKey() List<Media> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}


/// Create a copy of Tweet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TweetCopyWith<_Tweet> get copyWith => __$TweetCopyWithImpl<_Tweet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TweetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tweet&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._media, _media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt,const DeepCollectionEquality().hash(_media));

@override
String toString() {
  return 'Tweet(id: $id, text: $text, createdAt: $createdAt, media: $media)';
}


}

/// @nodoc
abstract mixin class _$TweetCopyWith<$Res> implements $TweetCopyWith<$Res> {
  factory _$TweetCopyWith(_Tweet value, $Res Function(_Tweet) _then) = __$TweetCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, DateTime createdAt, List<Media> media
});




}
/// @nodoc
class __$TweetCopyWithImpl<$Res>
    implements _$TweetCopyWith<$Res> {
  __$TweetCopyWithImpl(this._self, this._then);

  final _Tweet _self;
  final $Res Function(_Tweet) _then;

/// Create a copy of Tweet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? createdAt = null,Object? media = null,}) {
  return _then(_Tweet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,
  ));
}


}


/// @nodoc
mixin _$Media {

 String get url; String get type;
/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaCopyWith<Media> get copyWith => _$MediaCopyWithImpl<Media>(this as Media, _$identity);

  /// Serializes this Media to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Media&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type);

@override
String toString() {
  return 'Media(url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class $MediaCopyWith<$Res>  {
  factory $MediaCopyWith(Media value, $Res Function(Media) _then) = _$MediaCopyWithImpl;
@useResult
$Res call({
 String url, String type
});




}
/// @nodoc
class _$MediaCopyWithImpl<$Res>
    implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._self, this._then);

  final Media _self;
  final $Res Function(Media) _then;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? type = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Media implements Media {
  const _Media({required this.url, required this.type});
  factory _Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

@override final  String url;
@override final  String type;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaCopyWith<_Media> get copyWith => __$MediaCopyWithImpl<_Media>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Media&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,type);

@override
String toString() {
  return 'Media(url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class _$MediaCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$MediaCopyWith(_Media value, $Res Function(_Media) _then) = __$MediaCopyWithImpl;
@override @useResult
$Res call({
 String url, String type
});




}
/// @nodoc
class __$MediaCopyWithImpl<$Res>
    implements _$MediaCopyWith<$Res> {
  __$MediaCopyWithImpl(this._self, this._then);

  final _Media _self;
  final $Res Function(_Media) _then;

/// Create a copy of Media
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? type = null,}) {
  return _then(_Media(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
