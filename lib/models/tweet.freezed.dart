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

 String get id; String get text; DateTime get createdAt; List<Media> get media; int get favoriteCount; int get retweetCount; String? get inReplyToStatusId; String? get inReplyToUserId; String? get inReplyToScreenName; bool get isRetweet; String? get retweetedStatusId; String? get retweetedUserScreenName; bool get isReply;
/// Create a copy of Tweet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetCopyWith<Tweet> get copyWith => _$TweetCopyWithImpl<Tweet>(this as Tweet, _$identity);

  /// Serializes this Tweet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tweet&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.retweetCount, retweetCount) || other.retweetCount == retweetCount)&&(identical(other.inReplyToStatusId, inReplyToStatusId) || other.inReplyToStatusId == inReplyToStatusId)&&(identical(other.inReplyToUserId, inReplyToUserId) || other.inReplyToUserId == inReplyToUserId)&&(identical(other.inReplyToScreenName, inReplyToScreenName) || other.inReplyToScreenName == inReplyToScreenName)&&(identical(other.isRetweet, isRetweet) || other.isRetweet == isRetweet)&&(identical(other.retweetedStatusId, retweetedStatusId) || other.retweetedStatusId == retweetedStatusId)&&(identical(other.retweetedUserScreenName, retweetedUserScreenName) || other.retweetedUserScreenName == retweetedUserScreenName)&&(identical(other.isReply, isReply) || other.isReply == isReply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt,const DeepCollectionEquality().hash(media),favoriteCount,retweetCount,inReplyToStatusId,inReplyToUserId,inReplyToScreenName,isRetweet,retweetedStatusId,retweetedUserScreenName,isReply);

@override
String toString() {
  return 'Tweet(id: $id, text: $text, createdAt: $createdAt, media: $media, favoriteCount: $favoriteCount, retweetCount: $retweetCount, inReplyToStatusId: $inReplyToStatusId, inReplyToUserId: $inReplyToUserId, inReplyToScreenName: $inReplyToScreenName, isRetweet: $isRetweet, retweetedStatusId: $retweetedStatusId, retweetedUserScreenName: $retweetedUserScreenName, isReply: $isReply)';
}


}

/// @nodoc
abstract mixin class $TweetCopyWith<$Res>  {
  factory $TweetCopyWith(Tweet value, $Res Function(Tweet) _then) = _$TweetCopyWithImpl;
@useResult
$Res call({
 String id, String text, DateTime createdAt, List<Media> media, int favoriteCount, int retweetCount, String? inReplyToStatusId, String? inReplyToUserId, String? inReplyToScreenName, bool isRetweet, String? retweetedStatusId, String? retweetedUserScreenName, bool isReply
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? createdAt = null,Object? media = null,Object? favoriteCount = null,Object? retweetCount = null,Object? inReplyToStatusId = freezed,Object? inReplyToUserId = freezed,Object? inReplyToScreenName = freezed,Object? isRetweet = null,Object? retweetedStatusId = freezed,Object? retweetedUserScreenName = freezed,Object? isReply = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,retweetCount: null == retweetCount ? _self.retweetCount : retweetCount // ignore: cast_nullable_to_non_nullable
as int,inReplyToStatusId: freezed == inReplyToStatusId ? _self.inReplyToStatusId : inReplyToStatusId // ignore: cast_nullable_to_non_nullable
as String?,inReplyToUserId: freezed == inReplyToUserId ? _self.inReplyToUserId : inReplyToUserId // ignore: cast_nullable_to_non_nullable
as String?,inReplyToScreenName: freezed == inReplyToScreenName ? _self.inReplyToScreenName : inReplyToScreenName // ignore: cast_nullable_to_non_nullable
as String?,isRetweet: null == isRetweet ? _self.isRetweet : isRetweet // ignore: cast_nullable_to_non_nullable
as bool,retweetedStatusId: freezed == retweetedStatusId ? _self.retweetedStatusId : retweetedStatusId // ignore: cast_nullable_to_non_nullable
as String?,retweetedUserScreenName: freezed == retweetedUserScreenName ? _self.retweetedUserScreenName : retweetedUserScreenName // ignore: cast_nullable_to_non_nullable
as String?,isReply: null == isReply ? _self.isReply : isReply // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tweet implements Tweet {
  const _Tweet({required this.id, required this.text, required this.createdAt, final  List<Media> media = const [], this.favoriteCount = 0, this.retweetCount = 0, this.inReplyToStatusId, this.inReplyToUserId, this.inReplyToScreenName, this.isRetweet = false, this.retweetedStatusId, this.retweetedUserScreenName, this.isReply = false}): _media = media;
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

@override@JsonKey() final  int favoriteCount;
@override@JsonKey() final  int retweetCount;
@override final  String? inReplyToStatusId;
@override final  String? inReplyToUserId;
@override final  String? inReplyToScreenName;
@override@JsonKey() final  bool isRetweet;
@override final  String? retweetedStatusId;
@override final  String? retweetedUserScreenName;
@override@JsonKey() final  bool isReply;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tweet&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.retweetCount, retweetCount) || other.retweetCount == retweetCount)&&(identical(other.inReplyToStatusId, inReplyToStatusId) || other.inReplyToStatusId == inReplyToStatusId)&&(identical(other.inReplyToUserId, inReplyToUserId) || other.inReplyToUserId == inReplyToUserId)&&(identical(other.inReplyToScreenName, inReplyToScreenName) || other.inReplyToScreenName == inReplyToScreenName)&&(identical(other.isRetweet, isRetweet) || other.isRetweet == isRetweet)&&(identical(other.retweetedStatusId, retweetedStatusId) || other.retweetedStatusId == retweetedStatusId)&&(identical(other.retweetedUserScreenName, retweetedUserScreenName) || other.retweetedUserScreenName == retweetedUserScreenName)&&(identical(other.isReply, isReply) || other.isReply == isReply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,createdAt,const DeepCollectionEquality().hash(_media),favoriteCount,retweetCount,inReplyToStatusId,inReplyToUserId,inReplyToScreenName,isRetweet,retweetedStatusId,retweetedUserScreenName,isReply);

@override
String toString() {
  return 'Tweet(id: $id, text: $text, createdAt: $createdAt, media: $media, favoriteCount: $favoriteCount, retweetCount: $retweetCount, inReplyToStatusId: $inReplyToStatusId, inReplyToUserId: $inReplyToUserId, inReplyToScreenName: $inReplyToScreenName, isRetweet: $isRetweet, retweetedStatusId: $retweetedStatusId, retweetedUserScreenName: $retweetedUserScreenName, isReply: $isReply)';
}


}

/// @nodoc
abstract mixin class _$TweetCopyWith<$Res> implements $TweetCopyWith<$Res> {
  factory _$TweetCopyWith(_Tweet value, $Res Function(_Tweet) _then) = __$TweetCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, DateTime createdAt, List<Media> media, int favoriteCount, int retweetCount, String? inReplyToStatusId, String? inReplyToUserId, String? inReplyToScreenName, bool isRetweet, String? retweetedStatusId, String? retweetedUserScreenName, bool isReply
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? createdAt = null,Object? media = null,Object? favoriteCount = null,Object? retweetCount = null,Object? inReplyToStatusId = freezed,Object? inReplyToUserId = freezed,Object? inReplyToScreenName = freezed,Object? isRetweet = null,Object? retweetedStatusId = freezed,Object? retweetedUserScreenName = freezed,Object? isReply = null,}) {
  return _then(_Tweet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<Media>,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,retweetCount: null == retweetCount ? _self.retweetCount : retweetCount // ignore: cast_nullable_to_non_nullable
as int,inReplyToStatusId: freezed == inReplyToStatusId ? _self.inReplyToStatusId : inReplyToStatusId // ignore: cast_nullable_to_non_nullable
as String?,inReplyToUserId: freezed == inReplyToUserId ? _self.inReplyToUserId : inReplyToUserId // ignore: cast_nullable_to_non_nullable
as String?,inReplyToScreenName: freezed == inReplyToScreenName ? _self.inReplyToScreenName : inReplyToScreenName // ignore: cast_nullable_to_non_nullable
as String?,isRetweet: null == isRetweet ? _self.isRetweet : isRetweet // ignore: cast_nullable_to_non_nullable
as bool,retweetedStatusId: freezed == retweetedStatusId ? _self.retweetedStatusId : retweetedStatusId // ignore: cast_nullable_to_non_nullable
as String?,retweetedUserScreenName: freezed == retweetedUserScreenName ? _self.retweetedUserScreenName : retweetedUserScreenName // ignore: cast_nullable_to_non_nullable
as String?,isReply: null == isReply ? _self.isReply : isReply // ignore: cast_nullable_to_non_nullable
as bool,
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
