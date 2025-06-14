// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tag {

 String get name; Set<String> get tweetIds;
/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagCopyWith<Tag> get copyWith => _$TagCopyWithImpl<Tag>(this as Tag, _$identity);

  /// Serializes this Tag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tag&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.tweetIds, tweetIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(tweetIds));

@override
String toString() {
  return 'Tag(name: $name, tweetIds: $tweetIds)';
}


}

/// @nodoc
abstract mixin class $TagCopyWith<$Res>  {
  factory $TagCopyWith(Tag value, $Res Function(Tag) _then) = _$TagCopyWithImpl;
@useResult
$Res call({
 String name, Set<String> tweetIds
});




}
/// @nodoc
class _$TagCopyWithImpl<$Res>
    implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._self, this._then);

  final Tag _self;
  final $Res Function(Tag) _then;

/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? tweetIds = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tweetIds: null == tweetIds ? _self.tweetIds : tweetIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tag implements Tag {
  const _Tag({required this.name, final  Set<String> tweetIds = const {}}): _tweetIds = tweetIds;
  factory _Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

@override final  String name;
 final  Set<String> _tweetIds;
@override@JsonKey() Set<String> get tweetIds {
  if (_tweetIds is EqualUnmodifiableSetView) return _tweetIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tweetIds);
}


/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagCopyWith<_Tag> get copyWith => __$TagCopyWithImpl<_Tag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tag&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._tweetIds, _tweetIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_tweetIds));

@override
String toString() {
  return 'Tag(name: $name, tweetIds: $tweetIds)';
}


}

/// @nodoc
abstract mixin class _$TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$TagCopyWith(_Tag value, $Res Function(_Tag) _then) = __$TagCopyWithImpl;
@override @useResult
$Res call({
 String name, Set<String> tweetIds
});




}
/// @nodoc
class __$TagCopyWithImpl<$Res>
    implements _$TagCopyWith<$Res> {
  __$TagCopyWithImpl(this._self, this._then);

  final _Tag _self;
  final $Res Function(_Tag) _then;

/// Create a copy of Tag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? tweetIds = null,}) {
  return _then(_Tag(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tweetIds: null == tweetIds ? _self._tweetIds : tweetIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
