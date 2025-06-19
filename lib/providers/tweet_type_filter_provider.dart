import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/tweet_type_filter_state.dart';
import 'repository_providers.dart';

class TweetTypeFilterController extends Notifier<TweetTypeFilterState> {
  @override
  TweetTypeFilterState build() {
    _initialize();
    return const TweetTypeFilterState();
  }

  Future<void> _initialize() async {
    final preferences = await ref.read(preferencesRepositoryProvider.future);
    final savedState = await preferences.getTweetTypeFilter();
    if (savedState != null) {
      state = savedState;
    }
  }

  Future<void> setShowReplies(bool value) async {
    state = state.copyWith(showReplies: value);
    await _saveToPreferences();
  }

  Future<void> setShowRetweets(bool value) async {
    state = state.copyWith(showRetweets: value);
    await _saveToPreferences();
  }

  Future<void> setShowRegular(bool value) async {
    state = state.copyWith(showRegular: value);
    await _saveToPreferences();
  }

  Future<void> clearAll() async {
    state = const TweetTypeFilterState();
    await _saveToPreferences();
  }

  Future<void> _saveToPreferences() async {
    final preferences = await ref.read(preferencesRepositoryProvider.future);
    await preferences.saveTweetTypeFilter(state);
  }
}

final tweetTypeFilterProvider =
    NotifierProvider<TweetTypeFilterController, TweetTypeFilterState>(
  () => TweetTypeFilterController(),
);