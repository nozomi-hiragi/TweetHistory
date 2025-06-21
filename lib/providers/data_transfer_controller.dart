import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tag.dart';
import '../models/tweet.dart';
import '../repository/preferences_repository.dart';
import '../repository/tweet_repository.dart';
import '../storage/tweet/tweet_storage.dart';
import 'repository_providers.dart';

class DataTransferController {
  final TweetRepository tweetRepository;
  final PreferencesRepository preferencesRepository;

  const DataTransferController({
    required this.tweetRepository,
    required this.preferencesRepository,
  });

  Future<Map<String, dynamic>> exportAll() async {
    final [
      tweets as List<Tweet>,
      tags as List<Tag>,
      deleted as Set<String>,
    ] = await Future.wait([
      tweetRepository.loadAllTweets(),
      tweetRepository.loadAllTags(),
      tweetRepository.loadDeletedIds(),
    ]);

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
        await Future.wait([
          tweetStore.clear(),
          tagStore.clear(),
          deletedStore.clear(),
        ]);

        final tweets =
            (tweetDb['tweets'] as List? ?? []).cast<Map<String, dynamic>>();
        final tags =
            (tweetDb['tags'] as List? ?? []).cast<Map<String, dynamic>>();
        final deleted =
            (tweetDb['deleted'] as List? ?? []).cast<Map<String, dynamic>>();

        await Future.wait([
          tweetStore.putList(tweets),
          tagStore.putList(tags),
          deletedStore.putList(deleted),
        ]);
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

final dataTransferControllerProvider = FutureProvider<DataTransferController>((
  ref,
) async {
  final tweetRepo = await ref.watch(tweetRepositoryProvider.future);
  final prefRepo = await ref.watch(preferencesRepositoryProvider.future);
  return DataTransferController(
    tweetRepository: tweetRepo,
    preferencesRepository: prefRepo,
  );
});
