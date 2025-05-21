import '../utils/timezone_utils.dart';

class Tweet {
  final String id;
  final String text;
  final DateTime createdAt;
  final List<Media> media;

  const Tweet({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.media,
  });

  factory Tweet.fromWrappedJson(Map<String, dynamic> json) {
    final inner = json['tweet'];
    if (inner is Map<String, dynamic>) {
      return Tweet.fromJson(inner);
    } else {
      throw Exception('tweetフィールドが不正です');
    }
  }

  factory Tweet.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    final text = json['full_text'] ?? '';
    final createdAtStr = json['created_at'] as String;
    final createdAt = parseTwitterDate(createdAtStr);

    final mediaJson = json['entities']?['media'] as List?;
    final media =
        mediaJson != null
            ? mediaJson.map((m) => Media.fromJson(m)).toList()
            : <Media>[];

    if (id == null) {
      print('id: $id');
      throw Exception('ツイートの必須データが欠落しています');
    }

    return Tweet(id: id, text: text, createdAt: createdAt, media: media);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'createdAt': createdAt.toIso8601String(),
    'media': media.map((m) => m.toJson()).toList(),
  };
}

class Media {
  final String url;
  final String type;

  const Media({required this.url, required this.type});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json['media_url_https'] ?? json['media_url'] ?? '',
      type: json['type'] ?? 'photo',
    );
  }

  Map<String, dynamic> toJson() => {'url': url, 'type': type};

  static List<Media>? fromList(dynamic list) {
    if (list is List) {
      return list.map((e) => Media.fromJson(e)).toList();
    }
    return null;
  }
}
