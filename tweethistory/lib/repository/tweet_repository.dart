import '../models/tweet.dart';
import '../storage/tweet/tweet_storage.dart';

class TweetRepository {
  late final TweetStorage storage;

  TweetRepository();

  Future<void> init() async {
    storage = await TweetStorage.create();
  }

  Future<void> saveTweets(List<Tweet> tweets) => storage.callTweetStore(
    (db, store) => store.putList(db, tweets, (tweet) => tweet.toJson()),
  );

  Future<List<Tweet>> loadAllTweets() =>
      storage.callTweetStore((db, store) => store.getAll(db, Tweet.fromJson));

  Future<void> deleteTweet(String id) =>
      storage.callTweetStore((db, store) => store.delete(db, id));

  Future<void> clearTweets() =>
      storage.callTweetStore((db, store) => store.clear(db));

  // 🔧 今後拡張するなら...
  // - タグフィルタ取得
  // - 削除タグ付きのみ取得
  // - IDで検索
  // - 100件チャンクで取得（圧縮対応）
}
