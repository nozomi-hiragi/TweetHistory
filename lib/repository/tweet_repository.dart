import 'package:idb_shim/idb.dart';

import '../models/tag.dart';
import '../models/tweet.dart';
import '../storage/tweet/tweet_storage.dart';

const tagNameBin = 'bin';

class TweetRepository {
  final TweetStorage storage;

  const TweetRepository._(this.storage);

  static Future<TweetRepository> create({IdbFactory? factory}) async {
    final storage = await TweetStorage.create(factory: factory);
    return TweetRepository._(storage);
  }

  Future<void> saveTweets(List<Tweet> tweets) => storage
      .store(TweetStores.tweets)
      .putList(tweets, (tweet) => tweet.toJson());

  Future<List<Tweet>> loadAllTweets() =>
      storage.store(TweetStores.tweets).getAll(Tweet.fromJson);

  Future<void> addTag(String name) {
    final tag = Tag(name: name);
    return storage.store(TweetStores.tags).add(tag.toJson());
  }

  Future<Set<String>?> saveTag(Tag tag) async {
    await storage.store(TweetStores.tags).put(tag.toJson());
    return tag.tweetIds;
  }

  Future<Set<String>?> removeIdsFromTag(Tag tag, Set<String> ids) async {
    final updatedIds = tag.tweetIds.difference(ids);
    final updatedTag = tag.copyWith(tweetIds: updatedIds);
    return saveTag(updatedTag);
  }

  Future<Tag?> loadTag(String name) async {
    final obj = await storage.store(TweetStores.tags).get(name);
    if (obj == null) return null;
    return Tag.fromJson(obj as Map<String, dynamic>);
  }

  Future<List<Tag>> loadAllTags() =>
      storage.store(TweetStores.tags).getAll(Tag.fromJson);

  Future<List<Tag>> loadTags() => loadAllTags().then(
    (tags) => tags.where((tag) => tag.name != tagNameBin).toList(),
  );

  Future<void> deleteTweets(Set<String> ids) async {
    // store deleted ids
    await storage.store(TweetStores.deleted)
        .putList(ids.toList(), (id) => {'id': id});

    // delete tweet records
    final tweetStore = storage.store(TweetStores.tweets);
    for (final id in ids) {
      await tweetStore.delete(id);
    }

    // remove ids from all tags
    final tags = await loadAllTags();
    for (final tag in tags) {
      if (tag.tweetIds.intersection(ids).isEmpty) continue;
      await saveTag(tag.copyWith(tweetIds: tag.tweetIds.difference(ids)));
    }
  }

  Future<void> restoreTweets(Set<String> ids) async {
    final binTag = await loadTag(tagNameBin);
    if (binTag == null) return;
    await removeIdsFromTag(binTag, ids);
  }

  Future<Set<String>> loadDeletedIds() async {
    final objs = await storage.store(TweetStores.deleted).getAll((obj) => obj);
    return objs.map((e) => e['id'] as String).toSet();
  }
}
