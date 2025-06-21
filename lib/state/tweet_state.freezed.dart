// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TweetState {
  List<Tweet> get tweets => throw _privateConstructorUsedError;
  List<Tweet> get binned => throw _privateConstructorUsedError;

  /// Create a copy of TweetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TweetStateCopyWith<TweetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetStateCopyWith<$Res> {
  factory $TweetStateCopyWith(
    TweetState value,
    $Res Function(TweetState) then,
  ) = _$TweetStateCopyWithImpl<$Res, TweetState>;
  @useResult
  $Res call({List<Tweet> tweets, List<Tweet> binned});
}

/// @nodoc
class _$TweetStateCopyWithImpl<$Res, $Val extends TweetState>
    implements $TweetStateCopyWith<$Res> {
  _$TweetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TweetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tweets = null, Object? binned = null}) {
    return _then(
      _value.copyWith(
            tweets:
                null == tweets
                    ? _value.tweets
                    : tweets // ignore: cast_nullable_to_non_nullable
                        as List<Tweet>,
            binned:
                null == binned
                    ? _value.binned
                    : binned // ignore: cast_nullable_to_non_nullable
                        as List<Tweet>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TweetStateImplCopyWith<$Res>
    implements $TweetStateCopyWith<$Res> {
  factory _$$TweetStateImplCopyWith(
    _$TweetStateImpl value,
    $Res Function(_$TweetStateImpl) then,
  ) = __$$TweetStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Tweet> tweets, List<Tweet> binned});
}

/// @nodoc
class __$$TweetStateImplCopyWithImpl<$Res>
    extends _$TweetStateCopyWithImpl<$Res, _$TweetStateImpl>
    implements _$$TweetStateImplCopyWith<$Res> {
  __$$TweetStateImplCopyWithImpl(
    _$TweetStateImpl _value,
    $Res Function(_$TweetStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TweetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tweets = null, Object? binned = null}) {
    return _then(
      _$TweetStateImpl(
        tweets:
            null == tweets
                ? _value._tweets
                : tweets // ignore: cast_nullable_to_non_nullable
                    as List<Tweet>,
        binned:
            null == binned
                ? _value._binned
                : binned // ignore: cast_nullable_to_non_nullable
                    as List<Tweet>,
      ),
    );
  }
}

/// @nodoc

class _$TweetStateImpl implements _TweetState {
  const _$TweetStateImpl({
    required final List<Tweet> tweets,
    final List<Tweet> binned = const [],
  }) : _tweets = tweets,
       _binned = binned;

  final List<Tweet> _tweets;
  @override
  List<Tweet> get tweets {
    if (_tweets is EqualUnmodifiableListView) return _tweets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tweets);
  }

  final List<Tweet> _binned;
  @override
  @JsonKey()
  List<Tweet> get binned {
    if (_binned is EqualUnmodifiableListView) return _binned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_binned);
  }

  @override
  String toString() {
    return 'TweetState(tweets: $tweets, binned: $binned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TweetStateImpl &&
            const DeepCollectionEquality().equals(other._tweets, _tweets) &&
            const DeepCollectionEquality().equals(other._binned, _binned));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tweets),
    const DeepCollectionEquality().hash(_binned),
  );

  /// Create a copy of TweetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TweetStateImplCopyWith<_$TweetStateImpl> get copyWith =>
      __$$TweetStateImplCopyWithImpl<_$TweetStateImpl>(this, _$identity);
}

abstract class _TweetState implements TweetState {
  const factory _TweetState({
    required final List<Tweet> tweets,
    final List<Tweet> binned,
  }) = _$TweetStateImpl;

  @override
  List<Tweet> get tweets;
  @override
  List<Tweet> get binned;

  /// Create a copy of TweetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TweetStateImplCopyWith<_$TweetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
