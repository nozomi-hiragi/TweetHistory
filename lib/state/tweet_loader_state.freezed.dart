// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_loader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TweetLoaderState {

 double get progress; List<Tweet> get tweets; String? get error;
/// Create a copy of TweetLoaderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetLoaderStateCopyWith<TweetLoaderState> get copyWith => _$TweetLoaderStateCopyWithImpl<TweetLoaderState>(this as TweetLoaderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TweetLoaderState&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.tweets, tweets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(tweets),error);

@override
String toString() {
  return 'TweetLoaderState(progress: $progress, tweets: $tweets, error: $error)';
}


}

/// @nodoc
abstract mixin class $TweetLoaderStateCopyWith<$Res>  {
  factory $TweetLoaderStateCopyWith(TweetLoaderState value, $Res Function(TweetLoaderState) _then) = _$TweetLoaderStateCopyWithImpl;
@useResult
$Res call({
 double progress, List<Tweet> tweets, String? error
});




}
/// @nodoc
class _$TweetLoaderStateCopyWithImpl<$Res>
    implements $TweetLoaderStateCopyWith<$Res> {
  _$TweetLoaderStateCopyWithImpl(this._self, this._then);

  final TweetLoaderState _self;
  final $Res Function(TweetLoaderState) _then;

/// Create a copy of TweetLoaderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? tweets = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,tweets: null == tweets ? _self.tweets : tweets // ignore: cast_nullable_to_non_nullable
as List<Tweet>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TweetLoaderState implements TweetLoaderState {
  const _TweetLoaderState({this.progress = 0.0, final  List<Tweet> tweets = const [], this.error}): _tweets = tweets;
  

@override@JsonKey() final  double progress;
 final  List<Tweet> _tweets;
@override@JsonKey() List<Tweet> get tweets {
  if (_tweets is EqualUnmodifiableListView) return _tweets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tweets);
}

@override final  String? error;

/// Create a copy of TweetLoaderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TweetLoaderStateCopyWith<_TweetLoaderState> get copyWith => __$TweetLoaderStateCopyWithImpl<_TweetLoaderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TweetLoaderState&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._tweets, _tweets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,progress,const DeepCollectionEquality().hash(_tweets),error);

@override
String toString() {
  return 'TweetLoaderState(progress: $progress, tweets: $tweets, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TweetLoaderStateCopyWith<$Res> implements $TweetLoaderStateCopyWith<$Res> {
  factory _$TweetLoaderStateCopyWith(_TweetLoaderState value, $Res Function(_TweetLoaderState) _then) = __$TweetLoaderStateCopyWithImpl;
@override @useResult
$Res call({
 double progress, List<Tweet> tweets, String? error
});




}
/// @nodoc
class __$TweetLoaderStateCopyWithImpl<$Res>
    implements _$TweetLoaderStateCopyWith<$Res> {
  __$TweetLoaderStateCopyWithImpl(this._self, this._then);

  final _TweetLoaderState _self;
  final $Res Function(_TweetLoaderState) _then;

/// Create a copy of TweetLoaderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? tweets = null,Object? error = freezed,}) {
  return _then(_TweetLoaderState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,tweets: null == tweets ? _self._tweets : tweets // ignore: cast_nullable_to_non_nullable
as List<Tweet>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
