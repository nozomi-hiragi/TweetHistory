// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TweetState {

 List<Tweet> get tweets; List<Tweet> get binned;
/// Create a copy of TweetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetStateCopyWith<TweetState> get copyWith => _$TweetStateCopyWithImpl<TweetState>(this as TweetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TweetState&&const DeepCollectionEquality().equals(other.tweets, tweets)&&const DeepCollectionEquality().equals(other.binned, binned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tweets),const DeepCollectionEquality().hash(binned));

@override
String toString() {
  return 'TweetState(tweets: $tweets, binned: $binned)';
}


}

/// @nodoc
abstract mixin class $TweetStateCopyWith<$Res>  {
  factory $TweetStateCopyWith(TweetState value, $Res Function(TweetState) _then) = _$TweetStateCopyWithImpl;
@useResult
$Res call({
 List<Tweet> tweets, List<Tweet> binned
});




}
/// @nodoc
class _$TweetStateCopyWithImpl<$Res>
    implements $TweetStateCopyWith<$Res> {
  _$TweetStateCopyWithImpl(this._self, this._then);

  final TweetState _self;
  final $Res Function(TweetState) _then;

/// Create a copy of TweetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tweets = null,Object? binned = null,}) {
  return _then(_self.copyWith(
tweets: null == tweets ? _self.tweets : tweets // ignore: cast_nullable_to_non_nullable
as List<Tweet>,binned: null == binned ? _self.binned : binned // ignore: cast_nullable_to_non_nullable
as List<Tweet>,
  ));
}

}


/// @nodoc


class _TweetState implements TweetState {
  const _TweetState({required final  List<Tweet> tweets, final  List<Tweet> binned = const []}): _tweets = tweets,_binned = binned;
  

 final  List<Tweet> _tweets;
@override List<Tweet> get tweets {
  if (_tweets is EqualUnmodifiableListView) return _tweets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tweets);
}

 final  List<Tweet> _binned;
@override@JsonKey() List<Tweet> get binned {
  if (_binned is EqualUnmodifiableListView) return _binned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_binned);
}


/// Create a copy of TweetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TweetStateCopyWith<_TweetState> get copyWith => __$TweetStateCopyWithImpl<_TweetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TweetState&&const DeepCollectionEquality().equals(other._tweets, _tweets)&&const DeepCollectionEquality().equals(other._binned, _binned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tweets),const DeepCollectionEquality().hash(_binned));

@override
String toString() {
  return 'TweetState(tweets: $tweets, binned: $binned)';
}


}

/// @nodoc
abstract mixin class _$TweetStateCopyWith<$Res> implements $TweetStateCopyWith<$Res> {
  factory _$TweetStateCopyWith(_TweetState value, $Res Function(_TweetState) _then) = __$TweetStateCopyWithImpl;
@override @useResult
$Res call({
 List<Tweet> tweets, List<Tweet> binned
});




}
/// @nodoc
class __$TweetStateCopyWithImpl<$Res>
    implements _$TweetStateCopyWith<$Res> {
  __$TweetStateCopyWithImpl(this._self, this._then);

  final _TweetState _self;
  final $Res Function(_TweetState) _then;

/// Create a copy of TweetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tweets = null,Object? binned = null,}) {
  return _then(_TweetState(
tweets: null == tweets ? _self._tweets : tweets // ignore: cast_nullable_to_non_nullable
as List<Tweet>,binned: null == binned ? _self._binned : binned // ignore: cast_nullable_to_non_nullable
as List<Tweet>,
  ));
}


}

// dart format on
