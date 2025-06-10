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

  Future<List<Tweet>> loadAllTweets() =>
      storage.callTweetStore((db, store) => store.getAll(db, Tweet.fromJson));

  Future<void> deleteTweet(String id) =>
      storage.callTweetStore((db, store) => store.delete(db, id));

  Future<void> clearTweets() =>
      storage.callTweetStore((db, store) => store.clear(db));

  Future addTag(String name) {
    final tag = Tag(name: name);
    return storage.callTags((db, store) {
      return store.add(db, tag.toJson());
    });
  }

  Future<Tag?> getTag(String name) {
    return storage.callTags((db, store) {
      return store.get(db, name).then((obj) {
        if (obj == null) return null;
        final tag = Tag.fromJson(obj as Map<String, dynamic>);
        return tag;
      });
    });
  }

  Future<List<Tag>> getTags() {
    return storage.callTags((db, store) {
      return store
          .getAll(db, Tag.fromJson)
          .then((tags) => tags.where((tag) => tag.name != "bin").toList());
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

  Future<Set<String>?> removeTag(String tagName, Set<String> ids) async {
    final tag = await getTag(tagName);
    if (tag == null) {
      return null;
    }
    final updatedIds = tag.tweetIds.difference(ids);
    final updatedTag = tag.copyWith(tweetIds: updatedIds);
    await storage.callTags((db, store) => store.put(db, updatedTag.toJson()));
    return updatedTag.tweetIds;
  }

  // 🔧 今後拡張するなら...
  // - タグフィルタ取得
  // - 削除タグ付きのみ取得
  // - IDで検索
  // - 100件チャンクで取得（圧縮対応）
}
