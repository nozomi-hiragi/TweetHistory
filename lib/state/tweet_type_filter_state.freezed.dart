// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_type_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TweetTypeFilterState {

 bool get showReplies; bool get showRetweets; bool get showRegular;
/// Create a copy of TweetTypeFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetTypeFilterStateCopyWith<TweetTypeFilterState> get copyWith => _$TweetTypeFilterStateCopyWithImpl<TweetTypeFilterState>(this as TweetTypeFilterState, _$identity);

  /// Serializes this TweetTypeFilterState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TweetTypeFilterState&&(identical(other.showReplies, showReplies) || other.showReplies == showReplies)&&(identical(other.showRetweets, showRetweets) || other.showRetweets == showRetweets)&&(identical(other.showRegular, showRegular) || other.showRegular == showRegular));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showReplies,showRetweets,showRegular);

@override
String toString() {
  return 'TweetTypeFilterState(showReplies: $showReplies, showRetweets: $showRetweets, showRegular: $showRegular)';
}


}

/// @nodoc
abstract mixin class $TweetTypeFilterStateCopyWith<$Res>  {
  factory $TweetTypeFilterStateCopyWith(TweetTypeFilterState value, $Res Function(TweetTypeFilterState) _then) = _$TweetTypeFilterStateCopyWithImpl;
@useResult
$Res call({
 bool showReplies, bool showRetweets, bool showRegular
});




}
/// @nodoc
class _$TweetTypeFilterStateCopyWithImpl<$Res>
    implements $TweetTypeFilterStateCopyWith<$Res> {
  _$TweetTypeFilterStateCopyWithImpl(this._self, this._then);

  final TweetTypeFilterState _self;
  final $Res Function(TweetTypeFilterState) _then;

/// Create a copy of TweetTypeFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showReplies = null,Object? showRetweets = null,Object? showRegular = null,}) {
  return _then(_self.copyWith(
showReplies: null == showReplies ? _self.showReplies : showReplies // ignore: cast_nullable_to_non_nullable
as bool,showRetweets: null == showRetweets ? _self.showRetweets : showRetweets // ignore: cast_nullable_to_non_nullable
as bool,showRegular: null == showRegular ? _self.showRegular : showRegular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TweetTypeFilterState implements TweetTypeFilterState {
  const _TweetTypeFilterState({this.showReplies = false, this.showRetweets = false, this.showRegular = false});
  factory _TweetTypeFilterState.fromJson(Map<String, dynamic> json) => _$TweetTypeFilterStateFromJson(json);

@override@JsonKey() final  bool showReplies;
@override@JsonKey() final  bool showRetweets;
@override@JsonKey() final  bool showRegular;

/// Create a copy of TweetTypeFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TweetTypeFilterStateCopyWith<_TweetTypeFilterState> get copyWith => __$TweetTypeFilterStateCopyWithImpl<_TweetTypeFilterState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TweetTypeFilterStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TweetTypeFilterState&&(identical(other.showReplies, showReplies) || other.showReplies == showReplies)&&(identical(other.showRetweets, showRetweets) || other.showRetweets == showRetweets)&&(identical(other.showRegular, showRegular) || other.showRegular == showRegular));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showReplies,showRetweets,showRegular);

@override
String toString() {
  return 'TweetTypeFilterState(showReplies: $showReplies, showRetweets: $showRetweets, showRegular: $showRegular)';
}


}

/// @nodoc
abstract mixin class _$TweetTypeFilterStateCopyWith<$Res> implements $TweetTypeFilterStateCopyWith<$Res> {
  factory _$TweetTypeFilterStateCopyWith(_TweetTypeFilterState value, $Res Function(_TweetTypeFilterState) _then) = __$TweetTypeFilterStateCopyWithImpl;
@override @useResult
$Res call({
 bool showReplies, bool showRetweets, bool showRegular
});




}
/// @nodoc
class __$TweetTypeFilterStateCopyWithImpl<$Res>
    implements _$TweetTypeFilterStateCopyWith<$Res> {
  __$TweetTypeFilterStateCopyWithImpl(this._self, this._then);

  final _TweetTypeFilterState _self;
  final $Res Function(_TweetTypeFilterState) _then;

/// Create a copy of TweetTypeFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showReplies = null,Object? showRetweets = null,Object? showRegular = null,}) {
  return _then(_TweetTypeFilterState(
showReplies: null == showReplies ? _self.showReplies : showReplies // ignore: cast_nullable_to_non_nullable
as bool,showRetweets: null == showRetweets ? _self.showRetweets : showRetweets // ignore: cast_nullable_to_non_nullable
as bool,showRegular: null == showRegular ? _self.showRegular : showRegular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
