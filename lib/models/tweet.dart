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
    @Default(0) int favoriteCount,
    @Default(0) int retweetCount,
    String? inReplyToStatusId,
    String? inReplyToUserId,
    String? inReplyToScreenName,
    @Default(false) bool isRetweet,
    String? retweetedStatusId,
    String? retweetedUserScreenName,
    @Default(false) bool isReply,
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

    // Reply information
    final inReplyToStatusId = tweet['in_reply_to_status_id_str'] as String?;
    final inReplyToUserId = tweet['in_reply_to_user_id_str'] as String?;
    final inReplyToScreenName = tweet['in_reply_to_screen_name'] as String?;

    // Retweet information
    final retweetedStatus = tweet['retweeted_status'] as Map<String, dynamic>?;
    final isRetweet = retweetedStatus != null || text.startsWith('RT @');
    
    String? retweetedStatusId;
    String? retweetedUserScreenName;
    
    if (retweetedStatus != null) {
      // Standard retweet with retweeted_status object
      retweetedStatusId = retweetedStatus['id_str'] as String?;
      retweetedUserScreenName = retweetedStatus['user']?['screen_name'] as String?;
    } else if (text.startsWith('RT @')) {
      // Text-based retweet, extract user from entities.user_mentions
      final userMentions = tweet['entities']?['user_mentions'] as List?;
      if (userMentions != null && userMentions.isNotEmpty) {
        final firstMention = userMentions.first as Map<String, dynamic>;
        retweetedUserScreenName = firstMention['screen_name'] as String?;
        // For text-based RTs, we might not have the original status ID
        retweetedStatusId = null;
      }
    }

    return Tweet(
      id: id,
      text: text,
      createdAt: createdAt,
      media: media,
      favoriteCount: favoriteCount,
      retweetCount: retweetCount,
      inReplyToStatusId: inReplyToStatusId,
      inReplyToUserId: inReplyToUserId,
      inReplyToScreenName: inReplyToScreenName,
      isRetweet: isRetweet,
      retweetedStatusId: retweetedStatusId,
      retweetedUserScreenName: retweetedUserScreenName,
      isReply: inReplyToStatusId != null,
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
