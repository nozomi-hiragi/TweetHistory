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
    final repo = TweetRepository._(storage);
    await repo._ensureCountFields();
    return repo;
  }

  Future<void> saveTweets(List<Tweet> tweets) => storage
      .store(TweetStores.tweets)
      .putList(tweets, converter: (tweet) => tweet.toJson());

  Future<List<Tweet>> loadAllTweets() =>
      storage.store(TweetStores.tweets).getAll(converter: Tweet.fromJson);

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

  /// Renames a tag by creating a new tag with the new name and deleting the old one
  /// Returns true if successful, false if the new name already exists or operation fails
  Future<bool> renameTag(String oldName, String newName) async {
    try {
      // Cannot rename system tags
      if (oldName == tagNameBin) return false;
      
      // Check if new name already exists
      final existingTag = await loadTag(newName);
      if (existingTag != null) return false;
      
      // Get the old tag
      final oldTag = await loadTag(oldName);
      if (oldTag == null) return false;
      
      // Create new tag with the same tweet IDs
      final newTag = Tag(name: newName, tweetIds: oldTag.tweetIds);
      
      // Save new tag and delete old tag in a transaction-like manner
      await saveTag(newTag);
      await _deleteTagByName(oldName);
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Deletes a tag completely
  /// Returns true if successful, false if tag is system tag or operation fails
  Future<bool> deleteTag(String tagName) async {
    try {
      // Cannot delete system tags
      if (tagName == tagNameBin) return false;
      
      // Check if tag exists
      final tag = await loadTag(tagName);
      if (tag == null) return false;
      
      // Delete the tag
      await _deleteTagByName(tagName);
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Helper method to delete a tag by name from storage
  Future<void> _deleteTagByName(String tagName) async {
    await storage.store(TweetStores.tags).delete(tagName);
  }

  Future<Tag?> loadTag(String name) async {
    final obj = await storage.store(TweetStores.tags).get(name);
    if (obj == null) return null;
    return Tag.fromJson(obj as Map<String, dynamic>);
  }

  Future<List<Tag>> loadAllTags() =>
      storage.store(TweetStores.tags).getAll(converter: Tag.fromJson);

  Future<List<Tag>> loadTags() => loadAllTags().then(
    (tags) => tags.where((tag) => tag.name != tagNameBin).toList(),
  );

  Future<void> deleteTweets(Set<String> ids) async {
    // store deleted ids
    await storage
        .store(TweetStores.deleted)
        .putList(ids.toList(), converter: (id) => {'id': id});

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
    final ids = await storage
        .store(TweetStores.deleted)
        .getAll(converter: (obj) => obj['id'] as String);
    return ids.toSet();
  }

  Future<void> _ensureCountFields() async {
    final store = storage.store(TweetStores.tweets);
    final records = await store.getAll(
      converter: (obj) => Map<String, dynamic>.from(obj),
    );
    for (final obj in records) {
      bool updated = false;
      if (!obj.containsKey('favoriteCount')) {
        obj['favoriteCount'] = 0;
        updated = true;
      }
      if (!obj.containsKey('retweetCount')) {
        obj['retweetCount'] = 0;
        updated = true;
      }
      if (updated) {
        await store.put(obj);
      }
    }
  }
}
