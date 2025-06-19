import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../state/tweet_type_filter_state.dart';

class PreferencesRepository {
  final SharedPreferences _instance;
  final String _keyThemeMode = 'themeMode';
  final String _keyUserId = 'userId';
  final String _keyLocale = 'locale';
  final String _keyLastSearchQuery = 'lastSearchQuery';
  final String _keyLastSelectedTags = 'lastSelectedTags';
  final String _keyLastPeriodSince = 'lastPeriodSince';
  final String _keyLastPeriodUntil = 'lastPeriodUntil';
  final String _keyTweetTypeFilter = 'tweetTypeFilter';

  const PreferencesRepository._(this._instance);

  static Future<PreferencesRepository> create() async {
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return PreferencesRepository._(instance);
  }

  set themeMode(ThemeMode mode) => _instance.setInt(_keyThemeMode, mode.index);
  ThemeMode get themeMode {
    final index = _instance.getInt(_keyThemeMode);
    return index == null ? ThemeMode.system : ThemeMode.values[index];
  }

  set userId(String? id) =>
      id == null
          ? _instance.remove(_keyUserId)
          : _instance.setString(_keyUserId, id);
  String? get userId => _instance.getString(_keyUserId);

  set locale(String locale) => _instance.setString(_keyLocale, locale);
  String get locale => _instance.getString(_keyLocale) ?? '';

  // フィルター設定の保存・読み込み
  set lastSearchQuery(String? query) =>
      query == null || query.isEmpty
          ? _instance.remove(_keyLastSearchQuery)
          : _instance.setString(_keyLastSearchQuery, query);
  String? get lastSearchQuery => _instance.getString(_keyLastSearchQuery);

  set lastSelectedTags(List<String> tags) =>
      tags.isEmpty
          ? _instance.remove(_keyLastSelectedTags)
          : _instance.setString(_keyLastSelectedTags, jsonEncode(tags));
  List<String> get lastSelectedTags {
    final tagsJson = _instance.getString(_keyLastSelectedTags);
    if (tagsJson == null) return [];
    try {
      return List<String>.from(jsonDecode(tagsJson));
    } catch (e) {
      return [];
    }
  }

  set lastPeriodSince(DateTime? since) =>
      since == null
          ? _instance.remove(_keyLastPeriodSince)
          : _instance.setString(_keyLastPeriodSince, since.toIso8601String());
  DateTime? get lastPeriodSince {
    final sinceStr = _instance.getString(_keyLastPeriodSince);
    if (sinceStr == null) return null;
    try {
      return DateTime.parse(sinceStr);
    } catch (e) {
      return null;
    }
  }

  set lastPeriodUntil(DateTime? until) =>
      until == null
          ? _instance.remove(_keyLastPeriodUntil)
          : _instance.setString(_keyLastPeriodUntil, until.toIso8601String());
  DateTime? get lastPeriodUntil {
    final untilStr = _instance.getString(_keyLastPeriodUntil);
    if (untilStr == null) return null;
    try {
      return DateTime.parse(untilStr);
    } catch (e) {
      return null;
    }
  }

  // ツイートタイプフィルターの保存・読み込み
  Future<void> saveTweetTypeFilter(TweetTypeFilterState state) async {
    await _instance.setString(_keyTweetTypeFilter, jsonEncode(state.toJson()));
  }

  Future<TweetTypeFilterState?> getTweetTypeFilter() async {
    final filterJson = _instance.getString(_keyTweetTypeFilter);
    if (filterJson == null) return null;
    try {
      return TweetTypeFilterState.fromJson(jsonDecode(filterJson));
    } catch (e) {
      return null;
    }
  }

  // 全フィルター設定をクリア
  void clearFilterSettings() {
    _instance.remove(_keyLastSearchQuery);
    _instance.remove(_keyLastSelectedTags);
    _instance.remove(_keyLastPeriodSince);
    _instance.remove(_keyLastPeriodUntil);
    _instance.remove(_keyTweetTypeFilter);
  }
}
