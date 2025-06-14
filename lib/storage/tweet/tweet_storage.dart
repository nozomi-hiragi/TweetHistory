import 'dart:async';
import 'package:idb_shim/idb_browser.dart';

import 'tag_store.dart';
import 'tweet_store.dart';

class TweetStorage {
  static const String _dbName = 'tweet_db';
  static const int _dbVersion = 1;

  static final tweetsStore = TweetsStore();
  static final tagStore = TagStore();

  final Database _db;

  TweetStorage._(db) : _db = db;

  static Future<TweetStorage> create() async {
    final factory = idbFactoryBrowser;
    final db = await factory.open(
      _dbName,
      version: _dbVersion,
      onUpgradeNeeded: (VersionChangeEvent e) {
        final db = e.database;
        for (var store in [tweetsStore, tagStore]) {
          store.createObjectStore(db);
        }
      },
    );
    final storage = TweetStorage._(db);
    return storage;
  }

  Future<T> callTweetStore<T>(
    Future<T> Function(Database db, TweetsStore store) action,
  ) => action(_db, tweetsStore);

  Future<T> callTags<T>(
    Future<T> Function(Database db, TagStore store) action,
  ) => action(_db, tagStore);
}
