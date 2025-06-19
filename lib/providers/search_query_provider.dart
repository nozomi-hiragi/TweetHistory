import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'repository_providers.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    // 起動時に保存済みの検索クエリを非同期で読み込み
    _loadSavedQuery();
    return '';
  }

  void _loadSavedQuery() async {
    try {
      final pref = await ref.read(preferencesRepositoryProvider.future);
      final lastQuery = pref.lastSearchQuery;
      if (lastQuery != null && lastQuery.isNotEmpty) {
        state = lastQuery;
      }
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }

  void updateQuery(String query) {
    state = query;
    // 変更時に自動保存
    _saveQuery(query);
  }

  void _saveQuery(String query) async {
    try {
      final pref = await ref.read(preferencesRepositoryProvider.future);
      pref.lastSearchQuery = query;
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }

  void set(String query) => updateQuery(query);

  void clear() => updateQuery('');
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);
