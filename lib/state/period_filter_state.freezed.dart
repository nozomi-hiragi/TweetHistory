// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PeriodFilterState {
  DateTime? get since => throw _privateConstructorUsedError;
  DateTime? get until => throw _privateConstructorUsedError;

  /// Create a copy of PeriodFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeriodFilterStateCopyWith<PeriodFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodFilterStateCopyWith<$Res> {
  factory $PeriodFilterStateCopyWith(
    PeriodFilterState value,
    $Res Function(PeriodFilterState) then,
  ) = _$PeriodFilterStateCopyWithImpl<$Res, PeriodFilterState>;
  @useResult
  $Res call({DateTime? since, DateTime? until});
}

/// @nodoc
class _$PeriodFilterStateCopyWithImpl<$Res, $Val extends PeriodFilterState>
    implements $PeriodFilterStateCopyWith<$Res> {
  _$PeriodFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeriodFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? since = freezed, Object? until = freezed}) {
    return _then(
      _value.copyWith(
            since:
                freezed == since
                    ? _value.since
                    : since // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            until:
                freezed == until
                    ? _value.until
                    : until // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeriodFilterStateImplCopyWith<$Res>
    implements $PeriodFilterStateCopyWith<$Res> {
  factory _$$PeriodFilterStateImplCopyWith(
    _$PeriodFilterStateImpl value,
    $Res Function(_$PeriodFilterStateImpl) then,
  ) = __$$PeriodFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? since, DateTime? until});
}

/// @nodoc
class __$$PeriodFilterStateImplCopyWithImpl<$Res>
    extends _$PeriodFilterStateCopyWithImpl<$Res, _$PeriodFilterStateImpl>
    implements _$$PeriodFilterStateImplCopyWith<$Res> {
  __$$PeriodFilterStateImplCopyWithImpl(
    _$PeriodFilterStateImpl _value,
    $Res Function(_$PeriodFilterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeriodFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? since = freezed, Object? until = freezed}) {
    return _then(
      _$PeriodFilterStateImpl(
        since:
            freezed == since
                ? _value.since
                : since // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        until:
            freezed == until
                ? _value.until
                : until // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$PeriodFilterStateImpl implements _PeriodFilterState {
  const _$PeriodFilterStateImpl({this.since, this.until});

  @override
  final DateTime? since;
  @override
  final DateTime? until;

  @override
  String toString() {
    return 'PeriodFilterState(since: $since, until: $until)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeriodFilterStateImpl &&
            (identical(other.since, since) || other.since == since) &&
            (identical(other.until, until) || other.until == until));
  }

  @override
  int get hashCode => Object.hash(runtimeType, since, until);

  /// Create a copy of PeriodFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeriodFilterStateImplCopyWith<_$PeriodFilterStateImpl> get copyWith =>
      __$$PeriodFilterStateImplCopyWithImpl<_$PeriodFilterStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PeriodFilterState implements PeriodFilterState {
  const factory _PeriodFilterState({
    final DateTime? since,
    final DateTime? until,
  }) = _$PeriodFilterStateImpl;

  @override
  DateTime? get since;
  @override
  DateTime? get until;

  /// Create a copy of PeriodFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeriodFilterStateImplCopyWith<_$PeriodFilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
