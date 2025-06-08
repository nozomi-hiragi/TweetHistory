import '../models/tag.dart';
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

  Future<List<Tweet>> _loadAllTweets() =>
      storage.callTweetStore((db, store) => store.getAll(db, Tweet.fromJson));

  Future<List<Tweet>> filteredTweets() async {
    final allTweets = await _loadAllTweets();
    final deletedIds = await storage.callTags((db, store) {
      return store.get(db, "bin").then((obj) {
        if (obj == null) return <String>{};
        final tag = Tag.fromJson(obj as Map<String, dynamic>);
        return tag.tweetIds;
      });
    });
    final filtered =
        allTweets.where((tweet) => !deletedIds.contains(tweet.id)).toList();

    return filtered;
  }

  Future<void> deleteTweet(String id) =>
      storage.callTweetStore((db, store) => store.delete(db, id));

  Future<void> clearTweets() =>
      storage.callTweetStore((db, store) => store.clear(db));

  Future<Tag?> getTag(String name) {
    return storage.callTags((db, store) {
      return store.get(db, name).then((obj) {
        if (obj == null) return null;
        final tag = Tag.fromJson(obj as Map<String, dynamic>);
        return tag;
      });
    });
  }

  Future<Set<String>?> setTag(String tagName, Set<String> ids) async {
    final tag = await getTag(tagName).then((tag) {
      if (tag != null) {
        return tag.copyWith(tweetIds: {...tag.tweetIds, ...ids});
      }
      if (tagName == "bin") {
        return Tag(name: tagName, tweetIds: ids);
      }
    });
    if (tag == null) {
      return null;
    }
    await storage.callTags((db, store) {
      return store.put(db, tag.toJson());
    });
    return tag.tweetIds;
  }

  // 🔧 今後拡張するなら...
  // - タグフィルタ取得
  // - 削除タグ付きのみ取得
  // - IDで検索
  // - 100件チャンクで取得（圧縮対応）
}
