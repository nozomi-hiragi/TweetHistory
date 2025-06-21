// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelectedValues {
  List<String> get selected => throw _privateConstructorUsedError;
  List<String> get unselected => throw _privateConstructorUsedError;

  /// Create a copy of SelectedValues
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedValuesCopyWith<SelectedValues> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedValuesCopyWith<$Res> {
  factory $SelectedValuesCopyWith(
    SelectedValues value,
    $Res Function(SelectedValues) then,
  ) = _$SelectedValuesCopyWithImpl<$Res, SelectedValues>;
  @useResult
  $Res call({List<String> selected, List<String> unselected});
}

/// @nodoc
class _$SelectedValuesCopyWithImpl<$Res, $Val extends SelectedValues>
    implements $SelectedValuesCopyWith<$Res> {
  _$SelectedValuesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedValues
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selected = null, Object? unselected = null}) {
    return _then(
      _value.copyWith(
            selected:
                null == selected
                    ? _value.selected
                    : selected // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            unselected:
                null == unselected
                    ? _value.unselected
                    : unselected // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedValuesImplCopyWith<$Res>
    implements $SelectedValuesCopyWith<$Res> {
  factory _$$SelectedValuesImplCopyWith(
    _$SelectedValuesImpl value,
    $Res Function(_$SelectedValuesImpl) then,
  ) = __$$SelectedValuesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> selected, List<String> unselected});
}

/// @nodoc
class __$$SelectedValuesImplCopyWithImpl<$Res>
    extends _$SelectedValuesCopyWithImpl<$Res, _$SelectedValuesImpl>
    implements _$$SelectedValuesImplCopyWith<$Res> {
  __$$SelectedValuesImplCopyWithImpl(
    _$SelectedValuesImpl _value,
    $Res Function(_$SelectedValuesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedValues
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selected = null, Object? unselected = null}) {
    return _then(
      _$SelectedValuesImpl(
        selected:
            null == selected
                ? _value._selected
                : selected // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        unselected:
            null == unselected
                ? _value._unselected
                : unselected // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$SelectedValuesImpl implements _SelectedValues {
  const _$SelectedValuesImpl({
    final List<String> selected = const [],
    final List<String> unselected = const [],
  }) : _selected = selected,
       _unselected = unselected;

  final List<String> _selected;
  @override
  @JsonKey()
  List<String> get selected {
    if (_selected is EqualUnmodifiableListView) return _selected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selected);
  }

  final List<String> _unselected;
  @override
  @JsonKey()
  List<String> get unselected {
    if (_unselected is EqualUnmodifiableListView) return _unselected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unselected);
  }

  @override
  String toString() {
    return 'SelectedValues(selected: $selected, unselected: $unselected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedValuesImpl &&
            const DeepCollectionEquality().equals(other._selected, _selected) &&
            const DeepCollectionEquality().equals(
              other._unselected,
              _unselected,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selected),
    const DeepCollectionEquality().hash(_unselected),
  );

  /// Create a copy of SelectedValues
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedValuesImplCopyWith<_$SelectedValuesImpl> get copyWith =>
      __$$SelectedValuesImplCopyWithImpl<_$SelectedValuesImpl>(
        this,
        _$identity,
      );
}

abstract class _SelectedValues implements SelectedValues {
  const factory _SelectedValues({
    final List<String> selected,
    final List<String> unselected,
  }) = _$SelectedValuesImpl;

  @override
  List<String> get selected;
  @override
  List<String> get unselected;

  /// Create a copy of SelectedValues
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedValuesImplCopyWith<_$SelectedValuesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
