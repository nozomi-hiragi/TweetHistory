// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_type_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TweetTypeFilterState _$TweetTypeFilterStateFromJson(Map<String, dynamic> json) {
  return _TweetTypeFilterState.fromJson(json);
}

/// @nodoc
mixin _$TweetTypeFilterState {
  bool get showReplies => throw _privateConstructorUsedError;
  bool get showRetweets => throw _privateConstructorUsedError;
  bool get showRegular => throw _privateConstructorUsedError;

  /// Serializes this TweetTypeFilterState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TweetTypeFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TweetTypeFilterStateCopyWith<TweetTypeFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetTypeFilterStateCopyWith<$Res> {
  factory $TweetTypeFilterStateCopyWith(
    TweetTypeFilterState value,
    $Res Function(TweetTypeFilterState) then,
  ) = _$TweetTypeFilterStateCopyWithImpl<$Res, TweetTypeFilterState>;
  @useResult
  $Res call({bool showReplies, bool showRetweets, bool showRegular});
}

/// @nodoc
class _$TweetTypeFilterStateCopyWithImpl<
  $Res,
  $Val extends TweetTypeFilterState
>
    implements $TweetTypeFilterStateCopyWith<$Res> {
  _$TweetTypeFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TweetTypeFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showReplies = null,
    Object? showRetweets = null,
    Object? showRegular = null,
  }) {
    return _then(
      _value.copyWith(
            showReplies:
                null == showReplies
                    ? _value.showReplies
                    : showReplies // ignore: cast_nullable_to_non_nullable
                        as bool,
            showRetweets:
                null == showRetweets
                    ? _value.showRetweets
                    : showRetweets // ignore: cast_nullable_to_non_nullable
                        as bool,
            showRegular:
                null == showRegular
                    ? _value.showRegular
                    : showRegular // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TweetTypeFilterStateImplCopyWith<$Res>
    implements $TweetTypeFilterStateCopyWith<$Res> {
  factory _$$TweetTypeFilterStateImplCopyWith(
    _$TweetTypeFilterStateImpl value,
    $Res Function(_$TweetTypeFilterStateImpl) then,
  ) = __$$TweetTypeFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showReplies, bool showRetweets, bool showRegular});
}

/// @nodoc
class __$$TweetTypeFilterStateImplCopyWithImpl<$Res>
    extends _$TweetTypeFilterStateCopyWithImpl<$Res, _$TweetTypeFilterStateImpl>
    implements _$$TweetTypeFilterStateImplCopyWith<$Res> {
  __$$TweetTypeFilterStateImplCopyWithImpl(
    _$TweetTypeFilterStateImpl _value,
    $Res Function(_$TweetTypeFilterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TweetTypeFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showReplies = null,
    Object? showRetweets = null,
    Object? showRegular = null,
  }) {
    return _then(
      _$TweetTypeFilterStateImpl(
        showReplies:
            null == showReplies
                ? _value.showReplies
                : showReplies // ignore: cast_nullable_to_non_nullable
                    as bool,
        showRetweets:
            null == showRetweets
                ? _value.showRetweets
                : showRetweets // ignore: cast_nullable_to_non_nullable
                    as bool,
        showRegular:
            null == showRegular
                ? _value.showRegular
                : showRegular // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TweetTypeFilterStateImpl implements _TweetTypeFilterState {
  const _$TweetTypeFilterStateImpl({
    this.showReplies = false,
    this.showRetweets = false,
    this.showRegular = false,
  });

  factory _$TweetTypeFilterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TweetTypeFilterStateImplFromJson(json);

  @override
  @JsonKey()
  final bool showReplies;
  @override
  @JsonKey()
  final bool showRetweets;
  @override
  @JsonKey()
  final bool showRegular;

  @override
  String toString() {
    return 'TweetTypeFilterState(showReplies: $showReplies, showRetweets: $showRetweets, showRegular: $showRegular)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TweetTypeFilterStateImpl &&
            (identical(other.showReplies, showReplies) ||
                other.showReplies == showReplies) &&
            (identical(other.showRetweets, showRetweets) ||
                other.showRetweets == showRetweets) &&
            (identical(other.showRegular, showRegular) ||
                other.showRegular == showRegular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showReplies, showRetweets, showRegular);

  /// Create a copy of TweetTypeFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TweetTypeFilterStateImplCopyWith<_$TweetTypeFilterStateImpl>
  get copyWith =>
      __$$TweetTypeFilterStateImplCopyWithImpl<_$TweetTypeFilterStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TweetTypeFilterStateImplToJson(this);
  }
}

abstract class _TweetTypeFilterState implements TweetTypeFilterState {
  const factory _TweetTypeFilterState({
    final bool showReplies,
    final bool showRetweets,
    final bool showRegular,
  }) = _$TweetTypeFilterStateImpl;

  factory _TweetTypeFilterState.fromJson(Map<String, dynamic> json) =
      _$TweetTypeFilterStateImpl.fromJson;

  @override
  bool get showReplies;
  @override
  bool get showRetweets;
  @override
  bool get showRegular;

  /// Create a copy of TweetTypeFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TweetTypeFilterStateImplCopyWith<_$TweetTypeFilterStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
