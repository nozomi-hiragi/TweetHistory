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

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
      id: json['id_str'] ?? json['id'].toString(),
      text: json['full_text'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      media: Media.fromList(json['extended_entities']?['media']) ?? [],
    );
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
