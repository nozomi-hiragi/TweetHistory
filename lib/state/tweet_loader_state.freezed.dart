// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_loader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TweetLoaderState {
  double get progress => throw _privateConstructorUsedError;
  List<Tweet> get tweets => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of TweetLoaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TweetLoaderStateCopyWith<TweetLoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetLoaderStateCopyWith<$Res> {
  factory $TweetLoaderStateCopyWith(
    TweetLoaderState value,
    $Res Function(TweetLoaderState) then,
  ) = _$TweetLoaderStateCopyWithImpl<$Res, TweetLoaderState>;
  @useResult
  $Res call({double progress, List<Tweet> tweets, String? error});
}

/// @nodoc
class _$TweetLoaderStateCopyWithImpl<$Res, $Val extends TweetLoaderState>
    implements $TweetLoaderStateCopyWith<$Res> {
  _$TweetLoaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TweetLoaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? tweets = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            progress:
                null == progress
                    ? _value.progress
                    : progress // ignore: cast_nullable_to_non_nullable
                        as double,
            tweets:
                null == tweets
                    ? _value.tweets
                    : tweets // ignore: cast_nullable_to_non_nullable
                        as List<Tweet>,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TweetLoaderStateImplCopyWith<$Res>
    implements $TweetLoaderStateCopyWith<$Res> {
  factory _$$TweetLoaderStateImplCopyWith(
    _$TweetLoaderStateImpl value,
    $Res Function(_$TweetLoaderStateImpl) then,
  ) = __$$TweetLoaderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double progress, List<Tweet> tweets, String? error});
}

/// @nodoc
class __$$TweetLoaderStateImplCopyWithImpl<$Res>
    extends _$TweetLoaderStateCopyWithImpl<$Res, _$TweetLoaderStateImpl>
    implements _$$TweetLoaderStateImplCopyWith<$Res> {
  __$$TweetLoaderStateImplCopyWithImpl(
    _$TweetLoaderStateImpl _value,
    $Res Function(_$TweetLoaderStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TweetLoaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? tweets = null,
    Object? error = freezed,
  }) {
    return _then(
      _$TweetLoaderStateImpl(
        progress:
            null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                    as double,
        tweets:
            null == tweets
                ? _value._tweets
                : tweets // ignore: cast_nullable_to_non_nullable
                    as List<Tweet>,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$TweetLoaderStateImpl implements _TweetLoaderState {
  const _$TweetLoaderStateImpl({
    this.progress = 0.0,
    final List<Tweet> tweets = const [],
    this.error,
  }) : _tweets = tweets;

  @override
  @JsonKey()
  final double progress;
  final List<Tweet> _tweets;
  @override
  @JsonKey()
  List<Tweet> get tweets {
    if (_tweets is EqualUnmodifiableListView) return _tweets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tweets);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'TweetLoaderState(progress: $progress, tweets: $tweets, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TweetLoaderStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other._tweets, _tweets) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    progress,
    const DeepCollectionEquality().hash(_tweets),
    error,
  );

  /// Create a copy of TweetLoaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TweetLoaderStateImplCopyWith<_$TweetLoaderStateImpl> get copyWith =>
      __$$TweetLoaderStateImplCopyWithImpl<_$TweetLoaderStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TweetLoaderState implements TweetLoaderState {
  const factory _TweetLoaderState({
    final double progress,
    final List<Tweet> tweets,
    final String? error,
  }) = _$TweetLoaderStateImpl;

  @override
  double get progress;
  @override
  List<Tweet> get tweets;
  @override
  String? get error;

  /// Create a copy of TweetLoaderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TweetLoaderStateImplCopyWith<_$TweetLoaderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
