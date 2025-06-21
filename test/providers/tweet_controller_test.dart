import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:idb_shim/idb_shim.dart';
import 'package:tweethistory/models/tag.dart';
import 'package:tweethistory/models/tweet.dart';
import 'package:tweethistory/providers/repository_providers.dart';
import 'package:tweethistory/providers/tweet_controller.dart';
import 'package:tweethistory/repository/tweet_repository.dart';
import 'package:tweethistory/repository/preferences_repository.dart';
import 'package:tweethistory/state/tweet_type_filter_state.dart';
import 'package:flutter/material.dart';

// Mock preferences repository
class MockPreferencesRepository implements PreferencesRepository {
  List<String> _lastSelectedTags = [];
  ThemeMode _themeMode = ThemeMode.system;
  String? _userId;
  String _locale = '';
  String? _lastSearchQuery;
  DateTime? _lastPeriodSince;
  DateTime? _lastPeriodUntil;
  TweetTypeFilterState? _tweetTypeFilter;

  @override
  List<String> get lastSelectedTags => _lastSelectedTags;

  @override
  set lastSelectedTags(List<String> tags) => _lastSelectedTags = tags;

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  set themeMode(ThemeMode mode) => _themeMode = mode;

  @override
  String? get userId => _userId;

  @override
  set userId(String? id) => _userId = id;

  @override
  String get locale => _locale;

  @override
  set locale(String locale) => _locale = locale;

  @override
  String? get lastSearchQuery => _lastSearchQuery;

  @override
  set lastSearchQuery(String? query) => _lastSearchQuery = query;

  @override
  DateTime? get lastPeriodSince => _lastPeriodSince;

  @override
  set lastPeriodSince(DateTime? since) => _lastPeriodSince = since;

  @override
  DateTime? get lastPeriodUntil => _lastPeriodUntil;

  @override
  set lastPeriodUntil(DateTime? until) => _lastPeriodUntil = until;

  @override
  Future<void> saveTweetTypeFilter(TweetTypeFilterState state) async {
    _tweetTypeFilter = state;
  }

  @override
  Future<TweetTypeFilterState?> getTweetTypeFilter() async {
    return _tweetTypeFilter;
  }

  @override
  void clearFilterSettings() {
    _lastSelectedTags = [];
    _lastSearchQuery = null;
    _lastPeriodSince = null;
    _lastPeriodUntil = null;
    _tweetTypeFilter = null;
  }
}

void main() {
  group('TweetController', () {
    late ProviderContainer container;
    late TweetRepository repository;
    setUp(() async {
      final idbFactory = idbFactoryMemory;
      await idbFactory.deleteDatabase('tweet_db');
      repository = await TweetRepository.create(factory: idbFactory);
      final mockPreferences = MockPreferencesRepository();
      container = ProviderContainer(
        overrides: [
          tweetRepositoryProvider.overrideWith((ref) async => repository),
          preferencesRepositoryProvider.overrideWith(
            (ref) async => mockPreferences,
          ),
        ],
      );
    });

    test('deleteTweet should remove tweet id from all tags', () async {
      await repository.saveTweets([
        Tweet(id: '1', text: 't1', createdAt: DateTime(2025, 1, 1)),
      ]);
      await repository.addTag('tag1');
      await repository.saveTag(Tag(name: 'tag1', tweetIds: {'1'}));

      final controller = container.read(tweetControllerProvider.notifier);
      await controller.deleteTweet('1');

      final tag = await repository.loadTag('tag1');
      expect(tag?.tweetIds.contains('1'), isFalse);
      final deletedIds = await repository.loadDeletedIds();
      expect(deletedIds.contains('1'), isTrue);
    });
  });
}
