// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tweet _$TweetFromJson(Map<String, dynamic> json) {
  return _Tweet.fromJson(json);
}

/// @nodoc
mixin _$Tweet {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<Media> get media => throw _privateConstructorUsedError;
  int get favoriteCount => throw _privateConstructorUsedError;
  int get retweetCount => throw _privateConstructorUsedError;
  String? get inReplyToStatusId => throw _privateConstructorUsedError;
  String? get inReplyToUserId => throw _privateConstructorUsedError;
  String? get inReplyToScreenName => throw _privateConstructorUsedError;
  bool get isRetweet => throw _privateConstructorUsedError;
  String? get retweetedStatusId => throw _privateConstructorUsedError;
  String? get retweetedUserScreenName => throw _privateConstructorUsedError;
  bool get isReply => throw _privateConstructorUsedError;

  /// Serializes this Tweet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tweet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TweetCopyWith<Tweet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetCopyWith<$Res> {
  factory $TweetCopyWith(Tweet value, $Res Function(Tweet) then) =
      _$TweetCopyWithImpl<$Res, Tweet>;
  @useResult
  $Res call({
    String id,
    String text,
    DateTime createdAt,
    List<Media> media,
    int favoriteCount,
    int retweetCount,
    String? inReplyToStatusId,
    String? inReplyToUserId,
    String? inReplyToScreenName,
    bool isRetweet,
    String? retweetedStatusId,
    String? retweetedUserScreenName,
    bool isReply,
  });
}

/// @nodoc
class _$TweetCopyWithImpl<$Res, $Val extends Tweet>
    implements $TweetCopyWith<$Res> {
  _$TweetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tweet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? createdAt = null,
    Object? media = null,
    Object? favoriteCount = null,
    Object? retweetCount = null,
    Object? inReplyToStatusId = freezed,
    Object? inReplyToUserId = freezed,
    Object? inReplyToScreenName = freezed,
    Object? isRetweet = null,
    Object? retweetedStatusId = freezed,
    Object? retweetedUserScreenName = freezed,
    Object? isReply = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            media:
                null == media
                    ? _value.media
                    : media // ignore: cast_nullable_to_non_nullable
                        as List<Media>,
            favoriteCount:
                null == favoriteCount
                    ? _value.favoriteCount
                    : favoriteCount // ignore: cast_nullable_to_non_nullable
                        as int,
            retweetCount:
                null == retweetCount
                    ? _value.retweetCount
                    : retweetCount // ignore: cast_nullable_to_non_nullable
                        as int,
            inReplyToStatusId:
                freezed == inReplyToStatusId
                    ? _value.inReplyToStatusId
                    : inReplyToStatusId // ignore: cast_nullable_to_non_nullable
                        as String?,
            inReplyToUserId:
                freezed == inReplyToUserId
                    ? _value.inReplyToUserId
                    : inReplyToUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            inReplyToScreenName:
                freezed == inReplyToScreenName
                    ? _value.inReplyToScreenName
                    : inReplyToScreenName // ignore: cast_nullable_to_non_nullable
                        as String?,
            isRetweet:
                null == isRetweet
                    ? _value.isRetweet
                    : isRetweet // ignore: cast_nullable_to_non_nullable
                        as bool,
            retweetedStatusId:
                freezed == retweetedStatusId
                    ? _value.retweetedStatusId
                    : retweetedStatusId // ignore: cast_nullable_to_non_nullable
                        as String?,
            retweetedUserScreenName:
                freezed == retweetedUserScreenName
                    ? _value.retweetedUserScreenName
                    : retweetedUserScreenName // ignore: cast_nullable_to_non_nullable
                        as String?,
            isReply:
                null == isReply
                    ? _value.isReply
                    : isReply // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TweetImplCopyWith<$Res> implements $TweetCopyWith<$Res> {
  factory _$$TweetImplCopyWith(
    _$TweetImpl value,
    $Res Function(_$TweetImpl) then,
  ) = __$$TweetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    DateTime createdAt,
    List<Media> media,
    int favoriteCount,
    int retweetCount,
    String? inReplyToStatusId,
    String? inReplyToUserId,
    String? inReplyToScreenName,
    bool isRetweet,
    String? retweetedStatusId,
    String? retweetedUserScreenName,
    bool isReply,
  });
}

/// @nodoc
class __$$TweetImplCopyWithImpl<$Res>
    extends _$TweetCopyWithImpl<$Res, _$TweetImpl>
    implements _$$TweetImplCopyWith<$Res> {
  __$$TweetImplCopyWithImpl(
    _$TweetImpl _value,
    $Res Function(_$TweetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tweet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? createdAt = null,
    Object? media = null,
    Object? favoriteCount = null,
    Object? retweetCount = null,
    Object? inReplyToStatusId = freezed,
    Object? inReplyToUserId = freezed,
    Object? inReplyToScreenName = freezed,
    Object? isRetweet = null,
    Object? retweetedStatusId = freezed,
    Object? retweetedUserScreenName = freezed,
    Object? isReply = null,
  }) {
    return _then(
      _$TweetImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        media:
            null == media
                ? _value._media
                : media // ignore: cast_nullable_to_non_nullable
                    as List<Media>,
        favoriteCount:
            null == favoriteCount
                ? _value.favoriteCount
                : favoriteCount // ignore: cast_nullable_to_non_nullable
                    as int,
        retweetCount:
            null == retweetCount
                ? _value.retweetCount
                : retweetCount // ignore: cast_nullable_to_non_nullable
                    as int,
        inReplyToStatusId:
            freezed == inReplyToStatusId
                ? _value.inReplyToStatusId
                : inReplyToStatusId // ignore: cast_nullable_to_non_nullable
                    as String?,
        inReplyToUserId:
            freezed == inReplyToUserId
                ? _value.inReplyToUserId
                : inReplyToUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        inReplyToScreenName:
            freezed == inReplyToScreenName
                ? _value.inReplyToScreenName
                : inReplyToScreenName // ignore: cast_nullable_to_non_nullable
                    as String?,
        isRetweet:
            null == isRetweet
                ? _value.isRetweet
                : isRetweet // ignore: cast_nullable_to_non_nullable
                    as bool,
        retweetedStatusId:
            freezed == retweetedStatusId
                ? _value.retweetedStatusId
                : retweetedStatusId // ignore: cast_nullable_to_non_nullable
                    as String?,
        retweetedUserScreenName:
            freezed == retweetedUserScreenName
                ? _value.retweetedUserScreenName
                : retweetedUserScreenName // ignore: cast_nullable_to_non_nullable
                    as String?,
        isReply:
            null == isReply
                ? _value.isReply
                : isReply // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TweetImpl implements _Tweet {
  const _$TweetImpl({
    required this.id,
    required this.text,
    required this.createdAt,
    final List<Media> media = const [],
    this.favoriteCount = 0,
    this.retweetCount = 0,
    this.inReplyToStatusId,
    this.inReplyToUserId,
    this.inReplyToScreenName,
    this.isRetweet = false,
    this.retweetedStatusId,
    this.retweetedUserScreenName,
    this.isReply = false,
  }) : _media = media;

  factory _$TweetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TweetImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final DateTime createdAt;
  final List<Media> _media;
  @override
  @JsonKey()
  List<Media> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  @JsonKey()
  final int favoriteCount;
  @override
  @JsonKey()
  final int retweetCount;
  @override
  final String? inReplyToStatusId;
  @override
  final String? inReplyToUserId;
  @override
  final String? inReplyToScreenName;
  @override
  @JsonKey()
  final bool isRetweet;
  @override
  final String? retweetedStatusId;
  @override
  final String? retweetedUserScreenName;
  @override
  @JsonKey()
  final bool isReply;

  @override
  String toString() {
    return 'Tweet(id: $id, text: $text, createdAt: $createdAt, media: $media, favoriteCount: $favoriteCount, retweetCount: $retweetCount, inReplyToStatusId: $inReplyToStatusId, inReplyToUserId: $inReplyToUserId, inReplyToScreenName: $inReplyToScreenName, isRetweet: $isRetweet, retweetedStatusId: $retweetedStatusId, retweetedUserScreenName: $retweetedUserScreenName, isReply: $isReply)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TweetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.favoriteCount, favoriteCount) ||
                other.favoriteCount == favoriteCount) &&
            (identical(other.retweetCount, retweetCount) ||
                other.retweetCount == retweetCount) &&
            (identical(other.inReplyToStatusId, inReplyToStatusId) ||
                other.inReplyToStatusId == inReplyToStatusId) &&
            (identical(other.inReplyToUserId, inReplyToUserId) ||
                other.inReplyToUserId == inReplyToUserId) &&
            (identical(other.inReplyToScreenName, inReplyToScreenName) ||
                other.inReplyToScreenName == inReplyToScreenName) &&
            (identical(other.isRetweet, isRetweet) ||
                other.isRetweet == isRetweet) &&
            (identical(other.retweetedStatusId, retweetedStatusId) ||
                other.retweetedStatusId == retweetedStatusId) &&
            (identical(
                  other.retweetedUserScreenName,
                  retweetedUserScreenName,
                ) ||
                other.retweetedUserScreenName == retweetedUserScreenName) &&
            (identical(other.isReply, isReply) || other.isReply == isReply));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    createdAt,
    const DeepCollectionEquality().hash(_media),
    favoriteCount,
    retweetCount,
    inReplyToStatusId,
    inReplyToUserId,
    inReplyToScreenName,
    isRetweet,
    retweetedStatusId,
    retweetedUserScreenName,
    isReply,
  );

  /// Create a copy of Tweet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TweetImplCopyWith<_$TweetImpl> get copyWith =>
      __$$TweetImplCopyWithImpl<_$TweetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TweetImplToJson(this);
  }
}

abstract class _Tweet implements Tweet {
  const factory _Tweet({
    required final String id,
    required final String text,
    required final DateTime createdAt,
    final List<Media> media,
    final int favoriteCount,
    final int retweetCount,
    final String? inReplyToStatusId,
    final String? inReplyToUserId,
    final String? inReplyToScreenName,
    final bool isRetweet,
    final String? retweetedStatusId,
    final String? retweetedUserScreenName,
    final bool isReply,
  }) = _$TweetImpl;

  factory _Tweet.fromJson(Map<String, dynamic> json) = _$TweetImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  DateTime get createdAt;
  @override
  List<Media> get media;
  @override
  int get favoriteCount;
  @override
  int get retweetCount;
  @override
  String? get inReplyToStatusId;
  @override
  String? get inReplyToUserId;
  @override
  String? get inReplyToScreenName;
  @override
  bool get isRetweet;
  @override
  String? get retweetedStatusId;
  @override
  String? get retweetedUserScreenName;
  @override
  bool get isReply;

  /// Create a copy of Tweet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TweetImplCopyWith<_$TweetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Media _$MediaFromJson(Map<String, dynamic> json) {
  return _Media.fromJson(json);
}

/// @nodoc
mixin _$Media {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this Media to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaCopyWith<Media> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaCopyWith<$Res> {
  factory $MediaCopyWith(Media value, $Res Function(Media) then) =
      _$MediaCopyWithImpl<$Res, Media>;
  @useResult
  $Res call({String url, String type});
}

/// @nodoc
class _$MediaCopyWithImpl<$Res, $Val extends Media>
    implements $MediaCopyWith<$Res> {
  _$MediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaImplCopyWith<$Res> implements $MediaCopyWith<$Res> {
  factory _$$MediaImplCopyWith(
    _$MediaImpl value,
    $Res Function(_$MediaImpl) then,
  ) = __$$MediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String type});
}

/// @nodoc
class __$$MediaImplCopyWithImpl<$Res>
    extends _$MediaCopyWithImpl<$Res, _$MediaImpl>
    implements _$$MediaImplCopyWith<$Res> {
  __$$MediaImplCopyWithImpl(
    _$MediaImpl _value,
    $Res Function(_$MediaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? type = null}) {
    return _then(
      _$MediaImpl(
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaImpl implements _Media {
  const _$MediaImpl({required this.url, required this.type});

  factory _$MediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaImplFromJson(json);

  @override
  final String url;
  @override
  final String type;

  @override
  String toString() {
    return 'Media(url: $url, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type);

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      __$$MediaImplCopyWithImpl<_$MediaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaImplToJson(this);
  }
}

abstract class _Media implements Media {
  const factory _Media({
    required final String url,
    required final String type,
  }) = _$MediaImpl;

  factory _Media.fromJson(Map<String, dynamic> json) = _$MediaImpl.fromJson;

  @override
  String get url;
  @override
  String get type;

  /// Create a copy of Media
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaImplCopyWith<_$MediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
