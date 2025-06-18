// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodFilterState {

 DateTime? get since; DateTime? get until;
/// Create a copy of PeriodFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodFilterStateCopyWith<PeriodFilterState> get copyWith => _$PeriodFilterStateCopyWithImpl<PeriodFilterState>(this as PeriodFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodFilterState&&(identical(other.since, since) || other.since == since)&&(identical(other.until, until) || other.until == until));
}


@override
int get hashCode => Object.hash(runtimeType,since,until);

@override
String toString() {
  return 'PeriodFilterState(since: $since, until: $until)';
}


}

/// @nodoc
abstract mixin class $PeriodFilterStateCopyWith<$Res>  {
  factory $PeriodFilterStateCopyWith(PeriodFilterState value, $Res Function(PeriodFilterState) _then) = _$PeriodFilterStateCopyWithImpl;
@useResult
$Res call({
 DateTime? since, DateTime? until
});




}
/// @nodoc
class _$PeriodFilterStateCopyWithImpl<$Res>
    implements $PeriodFilterStateCopyWith<$Res> {
  _$PeriodFilterStateCopyWithImpl(this._self, this._then);

  final PeriodFilterState _self;
  final $Res Function(PeriodFilterState) _then;

/// Create a copy of PeriodFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? since = freezed,Object? until = freezed,}) {
  return _then(_self.copyWith(
since: freezed == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime?,until: freezed == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _PeriodFilterState implements PeriodFilterState {
  const _PeriodFilterState({this.since, this.until});
  

@override final  DateTime? since;
@override final  DateTime? until;

/// Create a copy of PeriodFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodFilterStateCopyWith<_PeriodFilterState> get copyWith => __$PeriodFilterStateCopyWithImpl<_PeriodFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodFilterState&&(identical(other.since, since) || other.since == since)&&(identical(other.until, until) || other.until == until));
}


@override
int get hashCode => Object.hash(runtimeType,since,until);

@override
String toString() {
  return 'PeriodFilterState(since: $since, until: $until)';
}


}

/// @nodoc
abstract mixin class _$PeriodFilterStateCopyWith<$Res> implements $PeriodFilterStateCopyWith<$Res> {
  factory _$PeriodFilterStateCopyWith(_PeriodFilterState value, $Res Function(_PeriodFilterState) _then) = __$PeriodFilterStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? since, DateTime? until
});




}
/// @nodoc
class __$PeriodFilterStateCopyWithImpl<$Res>
    implements _$PeriodFilterStateCopyWith<$Res> {
  __$PeriodFilterStateCopyWithImpl(this._self, this._then);

  final _PeriodFilterState _self;
  final $Res Function(_PeriodFilterState) _then;

/// Create a copy of PeriodFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? since = freezed,Object? until = freezed,}) {
  return _then(_PeriodFilterState(
since: freezed == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as DateTime?,until: freezed == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
