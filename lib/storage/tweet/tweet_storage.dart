import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Database;

import '../database.dart';
import '../store.dart';
import '../store_params.dart';

class TweetStores {
  static final tweets = StoreParams('tweets', 'id');
  static final tags = StoreParams('tags', 'name');
  static final deleted = StoreParams('deleted', 'id');
  static final values = [tweets, tags, deleted];

  static Map<StoreParams, Store> create(Database db) =>
      StoreParams.createStores(db, TweetStores.values);
}

class TweetStorage {
  static const String _dbName = 'tweet_db';
  static const int _dbVersion = 2;
  final Map<StoreParams, Store> _stores;

  const TweetStorage._(this._stores);

  static Future<TweetStorage> create({IdbFactory? factory}) async {
    IdbFactory idbFactory;

    if (factory != null) {
      idbFactory = factory;
    } else if (kIsWeb) {
      idbFactory = idbFactoryBrowser;
    } else {
      // Desktop: Initialize sqflite and create idb factory
      sqfliteFfiInit();
      idbFactory = getIdbFactorySqflite(databaseFactoryFfi);
    }

    final db = await createDatabase(
      idbFactory,
      _dbName,
      version: _dbVersion,
      onUpgradeNeeded: (VersionChangeEvent e, createObjectStore) {
        createObjectStore(TweetStores.values);
      },
    );
    return TweetStorage._(TweetStores.create(db));
  }

  Store store(StoreParams type) =>
      _stores[type] ??
      (throw ArgumentError('Unknown store type: ${type.name}'));
}
