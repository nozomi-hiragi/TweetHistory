import '../models/tag.dart';
import '../models/tweet.dart';
import '../storage/tweet/tweet_storage.dart';

class TweetRepository {
  late final TweetStorage storage;

  TweetRepository();

  Future<void> init() async {
    storage = await TweetStorage.create();
  }

  Future<void> saveTweets(List<Tweet> tweets) => storage
      .store(TweetStores.tweets)
      .putList(tweets, (tweet) => tweet.toJson());

  Future<List<Tweet>> loadAllTweets() =>
      storage.store(TweetStores.tweets).getAll(Tweet.fromJson);

  Future<void> deleteTweet(String id) =>
      storage.store(TweetStores.tweets).delete(id);

  Future<void> clearTweets() => storage.store(TweetStores.tweets).clear();

  Future addTag(String name) {
    final tag = Tag(name: name);
    return storage.store(TweetStores.tags).add(tag.toJson());
  }

  Future<Tag?> getTag(String name) {
    return storage.store(TweetStores.tags).get(name).then((obj) {
      if (obj == null) return null;
      return Tag.fromJson(obj as Map<String, dynamic>);
    });
  }

  Future<List<Tag>> getTags() {
    return storage
        .store(TweetStores.tags)
        .getAll(Tag.fromJson)
        .then((tags) => tags.where((tag) => tag.name != "bin").toList());
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
    await storage.store(TweetStores.tags).put(tag.toJson());
    return tag.tweetIds;
  }

  Future<Set<String>?> removeTag(String tagName, Set<String> ids) async {
    final tag = await getTag(tagName);
    if (tag == null) {
      return null;
    }
    final updatedIds = tag.tweetIds.difference(ids);
    final updatedTag = tag.copyWith(tweetIds: updatedIds);
    await storage.store(TweetStores.tags).put(updatedTag.toJson());
    return updatedTag.tweetIds;
  }

  Future setBinTag(Set<String> ids) async {
    final tags = await storage.store(TweetStores.tags).getAll(Tag.fromJson);
    final removeFuture = Future.wait(
      tags
          .where((tag) => tag.name != "bin" && tag.tweetIds.any(ids.contains))
          .map((tag) => removeTag(tag.name, ids))
          .toList(),
    );
    final setBinFuture = setTag("bin", ids);
    return Future.wait([removeFuture, setBinFuture]);
  }

  // 🔧 今後拡張するなら...
  // - タグフィルタ取得
  // - 削除タグ付きのみ取得
  // - IDで検索
  // - 100件チャンクで取得（圧縮対応）
}
