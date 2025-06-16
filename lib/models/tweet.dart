import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timezone_utils.dart';

part 'tweet.freezed.dart';
part 'tweet.g.dart';

@freezed
abstract class Tweet with _$Tweet {
  const factory Tweet({
    required String id,
    required String text,
    required DateTime createdAt,
    @Default([]) List<Media> media,
    @JsonKey(defaultValue: 0) @Default(0) int favoriteCount,
    @JsonKey(defaultValue: 0) @Default(0) int retweetCount,
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);

  factory Tweet.fromRawJson(Map<String, dynamic> json) {
    final tweet = json['tweet'] as Map<String, dynamic>;

    final id = tweet['id'] as String;
    final text = tweet['full_text'] as String;
    final createdAt = parseTwitterDate(tweet['created_at'] as String);

    final favoriteCount =
        int.tryParse(tweet['favorite_count']?.toString() ?? '0') ?? 0;
    final retweetCount =
        int.tryParse(tweet['retweet_count']?.toString() ?? '0') ?? 0;

    final mediaJson = tweet['entities']?['media'] as List?;
    final media = mediaJson != null
        ? mediaJson.map((m) => Media.fromRawJson(m)).toList()
        : <Media>[];

    return Tweet(
      id: id,
      text: text,
      createdAt: createdAt,
      media: media,
      favoriteCount: favoriteCount,
      retweetCount: retweetCount,
    );
  }
}

@freezed
abstract class Media with _$Media {
  const factory Media({required String url, required String type}) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  factory Media.fromRawJson(Map<String, dynamic> json) {
    return Media(
      url: json['media_url_https'] ?? json['media_url'] ?? '',
      type: json['type'] ?? 'photo',
    );
  }
}
