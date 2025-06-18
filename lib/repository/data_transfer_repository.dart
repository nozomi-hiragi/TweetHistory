import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tweethistory/storage/tweet/tweet_storage.dart';

import 'tweet_repository.dart';
import 'preferences_repository.dart';

class DataTransferRepository {
  final TweetRepository tweetRepository;
  final PreferencesRepository preferencesRepository;

  const DataTransferRepository({
    required this.tweetRepository,
    required this.preferencesRepository,
  });

  Future<Map<String, dynamic>> exportAll() async {
    final tweets = await tweetRepository.loadAllTweets();
    final tags = await tweetRepository.loadAllTags();
    final deleted = await tweetRepository.loadDeletedIds();

    return {
      'indexedDB': {
        'tweet_db': {
          'tweets': tweets.map((t) => t.toJson()).toList(),
          'tags': tags.map((t) => t.toJson()).toList(),
          'deleted': deleted.map((id) => {'id': id}).toList(),
        },
      },
      'preferences': {
        'themeMode': preferencesRepository.themeMode.index,
        'userId': preferencesRepository.userId,
      },
    };
  }

  Future<void> importAll(Map<String, dynamic> data) async {
    final db = data['indexedDB'];
    if (db is Map) {
      final tweetDb = db['tweet_db'];
      if (tweetDb is Map) {
        final tweetStore = tweetRepository.storage.store(TweetStores.tweets);
        final tagStore = tweetRepository.storage.store(TweetStores.tags);
        final deletedStore = tweetRepository.storage.store(TweetStores.deleted);
        await tweetStore.clear();
        await tagStore.clear();
        await deletedStore.clear();

        final tweets =
            (tweetDb['tweets'] as List? ?? []).cast<Map<String, dynamic>>();
        final tags =
            (tweetDb['tags'] as List? ?? []).cast<Map<String, dynamic>>();
        final deleted =
            (tweetDb['deleted'] as List? ?? []).cast<Map<String, dynamic>>();

        await tweetStore.putList(tweets, (obj) => obj);
        await tagStore.putList(tags, (obj) => obj);
        await deletedStore.putList(deleted, (obj) => obj);
      }
    }

    final preferences = data['preferences'];
    if (preferences is Map) {
      final index = preferences['themeMode'];
      if (index is int && index >= 0 && index < ThemeMode.values.length) {
        preferencesRepository.themeMode = ThemeMode.values[index];
      }
      final userId = preferences['userId'];
      if (userId is String?) {
        preferencesRepository.userId = userId;
      }
    }
  }

  String exportJson(Map<String, dynamic> data) =>
      const JsonEncoder.withIndent('  ').convert(data);
}
