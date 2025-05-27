import '../models/tweet.dart';
import '../storage/tweet_storage.dart';

class TweetRepository {
  final TweetStorage storage;

  TweetRepository() : storage = TweetStorage();

  Future<void> init() async {
    await storage.init();
  }

  Future<void> saveTweets(List<Tweet> tweets) async {
    await storage.saveTweets(tweets);
  }

  Future<List<Tweet>> loadAllTweets() async {
    return await storage.loadTweets();
  }

  Future<void> deleteTweet(String id) async {
    await storage.deleteTweet(id);
  }

  Future<void> clearTweets() async {
    await storage.clearAllTweets();
  }

  // 🔧 今後拡張するなら...
  // - タグフィルタ取得
  // - 削除タグ付きのみ取得
  // - IDで検索
  // - 100件チャンクで取得（圧縮対応）
}
