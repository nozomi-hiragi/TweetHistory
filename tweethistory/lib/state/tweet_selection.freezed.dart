// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TweetSelectState {

 dynamic get isSelectionMode; Set<String> get selectedIds;
/// Create a copy of TweetSelectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TweetSelectStateCopyWith<TweetSelectState> get copyWith => _$TweetSelectStateCopyWithImpl<TweetSelectState>(this as TweetSelectState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TweetSelectState&&const DeepCollectionEquality().equals(other.isSelectionMode, isSelectionMode)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(isSelectionMode),const DeepCollectionEquality().hash(selectedIds));

@override
String toString() {
  return 'TweetSelectState(isSelectionMode: $isSelectionMode, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class $TweetSelectStateCopyWith<$Res>  {
  factory $TweetSelectStateCopyWith(TweetSelectState value, $Res Function(TweetSelectState) _then) = _$TweetSelectStateCopyWithImpl;
@useResult
$Res call({
 dynamic isSelectionMode, Set<String> selectedIds
});




}
/// @nodoc
class _$TweetSelectStateCopyWithImpl<$Res>
    implements $TweetSelectStateCopyWith<$Res> {
  _$TweetSelectStateCopyWithImpl(this._self, this._then);

  final TweetSelectState _self;
  final $Res Function(TweetSelectState) _then;

/// Create a copy of TweetSelectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSelectionMode = freezed,Object? selectedIds = null,}) {
  return _then(_self.copyWith(
isSelectionMode: freezed == isSelectionMode ? _self.isSelectionMode : isSelectionMode // ignore: cast_nullable_to_non_nullable
as dynamic,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// @nodoc


class _TweetSelectState implements TweetSelectState {
  const _TweetSelectState({this.isSelectionMode = false, final  Set<String> selectedIds = const <String>{}}): _selectedIds = selectedIds;
  

@override@JsonKey() final  dynamic isSelectionMode;
 final  Set<String> _selectedIds;
@override@JsonKey() Set<String> get selectedIds {
  if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIds);
}


/// Create a copy of TweetSelectState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TweetSelectStateCopyWith<_TweetSelectState> get copyWith => __$TweetSelectStateCopyWithImpl<_TweetSelectState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TweetSelectState&&const DeepCollectionEquality().equals(other.isSelectionMode, isSelectionMode)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(isSelectionMode),const DeepCollectionEquality().hash(_selectedIds));

@override
String toString() {
  return 'TweetSelectState(isSelectionMode: $isSelectionMode, selectedIds: $selectedIds)';
}


}

/// @nodoc
abstract mixin class _$TweetSelectStateCopyWith<$Res> implements $TweetSelectStateCopyWith<$Res> {
  factory _$TweetSelectStateCopyWith(_TweetSelectState value, $Res Function(_TweetSelectState) _then) = __$TweetSelectStateCopyWithImpl;
@override @useResult
$Res call({
 dynamic isSelectionMode, Set<String> selectedIds
});




}
/// @nodoc
class __$TweetSelectStateCopyWithImpl<$Res>
    implements _$TweetSelectStateCopyWith<$Res> {
  __$TweetSelectStateCopyWithImpl(this._self, this._then);

  final _TweetSelectState _self;
  final $Res Function(_TweetSelectState) _then;

/// Create a copy of TweetSelectState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSelectionMode = freezed,Object? selectedIds = null,}) {
  return _then(_TweetSelectState(
isSelectionMode: freezed == isSelectionMode ? _self.isSelectionMode : isSelectionMode // ignore: cast_nullable_to_non_nullable
as dynamic,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
