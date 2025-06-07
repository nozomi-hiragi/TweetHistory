// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagSelectionState {

 List<String> get selected; List<String> get unselected;
/// Create a copy of TagSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagSelectionStateCopyWith<TagSelectionState> get copyWith => _$TagSelectionStateCopyWithImpl<TagSelectionState>(this as TagSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagSelectionState&&const DeepCollectionEquality().equals(other.selected, selected)&&const DeepCollectionEquality().equals(other.unselected, unselected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selected),const DeepCollectionEquality().hash(unselected));

@override
String toString() {
  return 'TagSelectionState(selected: $selected, unselected: $unselected)';
}


}

/// @nodoc
abstract mixin class $TagSelectionStateCopyWith<$Res>  {
  factory $TagSelectionStateCopyWith(TagSelectionState value, $Res Function(TagSelectionState) _then) = _$TagSelectionStateCopyWithImpl;
@useResult
$Res call({
 List<String> selected, List<String> unselected
});




}
/// @nodoc
class _$TagSelectionStateCopyWithImpl<$Res>
    implements $TagSelectionStateCopyWith<$Res> {
  _$TagSelectionStateCopyWithImpl(this._self, this._then);

  final TagSelectionState _self;
  final $Res Function(TagSelectionState) _then;

/// Create a copy of TagSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selected = null,Object? unselected = null,}) {
  return _then(_self.copyWith(
selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as List<String>,unselected: null == unselected ? _self.unselected : unselected // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc


class _TagSelectionState implements TagSelectionState {
  const _TagSelectionState({final  List<String> selected = const [], final  List<String> unselected = const []}): _selected = selected,_unselected = unselected;
  

 final  List<String> _selected;
@override@JsonKey() List<String> get selected {
  if (_selected is EqualUnmodifiableListView) return _selected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selected);
}

 final  List<String> _unselected;
@override@JsonKey() List<String> get unselected {
  if (_unselected is EqualUnmodifiableListView) return _unselected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unselected);
}


/// Create a copy of TagSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagSelectionStateCopyWith<_TagSelectionState> get copyWith => __$TagSelectionStateCopyWithImpl<_TagSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagSelectionState&&const DeepCollectionEquality().equals(other._selected, _selected)&&const DeepCollectionEquality().equals(other._unselected, _unselected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selected),const DeepCollectionEquality().hash(_unselected));

@override
String toString() {
  return 'TagSelectionState(selected: $selected, unselected: $unselected)';
}


}

/// @nodoc
abstract mixin class _$TagSelectionStateCopyWith<$Res> implements $TagSelectionStateCopyWith<$Res> {
  factory _$TagSelectionStateCopyWith(_TagSelectionState value, $Res Function(_TagSelectionState) _then) = __$TagSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> selected, List<String> unselected
});




}
/// @nodoc
class __$TagSelectionStateCopyWithImpl<$Res>
    implements _$TagSelectionStateCopyWith<$Res> {
  __$TagSelectionStateCopyWithImpl(this._self, this._then);

  final _TagSelectionState _self;
  final $Res Function(_TagSelectionState) _then;

/// Create a copy of TagSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selected = null,Object? unselected = null,}) {
  return _then(_TagSelectionState(
selected: null == selected ? _self._selected : selected // ignore: cast_nullable_to_non_nullable
as List<String>,unselected: null == unselected ? _self._unselected : unselected // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
