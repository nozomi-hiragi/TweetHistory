import 'dart:async';
import 'package:idb_shim/idb_browser.dart';
import '../../../models/tweet.dart';

class TweetStorage {
  static const String _dbName = 'tweet_db';
  static const String _storeName = 'tweets';
  static const int _dbVersion = 1;

  late final Database _db;

  Future<void> init() async {
    final factory = idbFactoryBrowser;
    _db = await factory.open(
      _dbName,
      version: _dbVersion,
      onUpgradeNeeded: (VersionChangeEvent e) {
        final db = e.database;
        if (!db.objectStoreNames.contains(_storeName)) {
          db.createObjectStore(_storeName, keyPath: 'id');
        }
      },
    );
  }

  Future<void> saveTweets(List<Tweet> tweets) async {
    final txn = _db.transaction(_storeName, idbModeReadWrite);
    final store = txn.objectStore(_storeName);
    for (final tweet in tweets) {
      await store.put(tweet.toJson());
    }
    await txn.completed;
  }

  Future<List<Tweet>> loadTweets() async {
    final txn = _db.transaction(_storeName, idbModeReadOnly);
    final store = txn.objectStore(_storeName);
    final records = await store.getAll();
    await txn.completed;
    final List<Tweet> tweets =
        records.cast<Map<String, dynamic>>().map(Tweet.fromJson).toList();
    return tweets;
  }

  Future<void> deleteTweet(String id) async {
    final txn = _db.transaction(_storeName, idbModeReadWrite);
    final store = txn.objectStore(_storeName);
    await store.delete(id);
    await txn.completed;
  }

  Future<void> clearAllTweets() async {
    final txn = _db.transaction(_storeName, idbModeReadWrite);
    final store = txn.objectStore(_storeName);
    await store.clear();
    await txn.completed;
  }
}
