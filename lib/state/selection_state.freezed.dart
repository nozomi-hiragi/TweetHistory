// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SelectionState {
  SelectionMode get mode => throw _privateConstructorUsedError;
  Set<String> get selectedIds => throw _privateConstructorUsedError;

  /// Create a copy of SelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectionStateCopyWith<SelectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectionStateCopyWith<$Res> {
  factory $SelectionStateCopyWith(
    SelectionState value,
    $Res Function(SelectionState) then,
  ) = _$SelectionStateCopyWithImpl<$Res, SelectionState>;
  @useResult
  $Res call({SelectionMode mode, Set<String> selectedIds});
}

/// @nodoc
class _$SelectionStateCopyWithImpl<$Res, $Val extends SelectionState>
    implements $SelectionStateCopyWith<$Res> {
  _$SelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mode = null, Object? selectedIds = null}) {
    return _then(
      _value.copyWith(
            mode:
                null == mode
                    ? _value.mode
                    : mode // ignore: cast_nullable_to_non_nullable
                        as SelectionMode,
            selectedIds:
                null == selectedIds
                    ? _value.selectedIds
                    : selectedIds // ignore: cast_nullable_to_non_nullable
                        as Set<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectionStateImplCopyWith<$Res>
    implements $SelectionStateCopyWith<$Res> {
  factory _$$SelectionStateImplCopyWith(
    _$SelectionStateImpl value,
    $Res Function(_$SelectionStateImpl) then,
  ) = __$$SelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SelectionMode mode, Set<String> selectedIds});
}

/// @nodoc
class __$$SelectionStateImplCopyWithImpl<$Res>
    extends _$SelectionStateCopyWithImpl<$Res, _$SelectionStateImpl>
    implements _$$SelectionStateImplCopyWith<$Res> {
  __$$SelectionStateImplCopyWithImpl(
    _$SelectionStateImpl _value,
    $Res Function(_$SelectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mode = null, Object? selectedIds = null}) {
    return _then(
      _$SelectionStateImpl(
        mode:
            null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                    as SelectionMode,
        selectedIds:
            null == selectedIds
                ? _value._selectedIds
                : selectedIds // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$SelectionStateImpl extends _SelectionState {
  const _$SelectionStateImpl({
    this.mode = SelectionMode.normal,
    final Set<String> selectedIds = const <String>{},
  }) : _selectedIds = selectedIds,
       super._();

  @override
  @JsonKey()
  final SelectionMode mode;
  final Set<String> _selectedIds;
  @override
  @JsonKey()
  Set<String> get selectedIds {
    if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedIds);
  }

  @override
  String toString() {
    return 'SelectionState(mode: $mode, selectedIds: $selectedIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectionStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(
              other._selectedIds,
              _selectedIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    mode,
    const DeepCollectionEquality().hash(_selectedIds),
  );

  /// Create a copy of SelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectionStateImplCopyWith<_$SelectionStateImpl> get copyWith =>
      __$$SelectionStateImplCopyWithImpl<_$SelectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SelectionState extends SelectionState {
  const factory _SelectionState({
    final SelectionMode mode,
    final Set<String> selectedIds,
  }) = _$SelectionStateImpl;
  const _SelectionState._() : super._();

  @override
  SelectionMode get mode;
  @override
  Set<String> get selectedIds;

  /// Create a copy of SelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectionStateImplCopyWith<_$SelectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
