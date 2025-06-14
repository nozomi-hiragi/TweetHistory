import 'package:flutter_test/flutter_test.dart';
import 'package:tweethistory/features/tweets/data/tweet_file_parser.dart';

void main() {
  group('extractJsonArray', () {
    test('trims prefix and semicolon', () {
      const js = 'window.YTD.tweets.part0 = [1,2,3];';
      expect(extractJsonArray(js), '[1,2,3]');
    });

    test('throws when prefix is missing', () {
      expect(() => extractJsonArray('[1,2,3];'), throwsException);
    });
  });

  test('parseTweetsFromJs parses tweet objects', () {
    const raw =
        'window.YTD.tweets.part0 = [{"tweet":{"id":"1","full_text":"hello","created_at":"Wed Aug 23 16:35:51 +0000 2023","entities":{"media":[{"media_url_https":"https://example.com/photo.jpg","type":"photo"}]}}}];';

    final tweets = parseTweetsFromJs(raw);

    expect(tweets.length, 1);
    final tweet = tweets.first;
    expect(tweet.id, '1');
    expect(tweet.text, 'hello');
    expect(tweet.createdAt.toUtc(), DateTime.utc(2023, 8, 23, 16, 35, 51));
    expect(tweet.media, hasLength(1));
    final media = tweet.media.first;
    expect(media.url, 'https://example.com/photo.jpg');
    expect(media.type, 'photo');
  });

  test('parseTweetsFromJs throws on invalid json', () {
    const raw = 'window.YTD.tweets.part0 = invalid;';
    expect(() => parseTweetsFromJs(raw), throwsException);
  });
}
