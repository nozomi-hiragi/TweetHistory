import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/selected_values.dart';
import 'repository_providers.dart';

class TagSelectController extends Notifier<SelectedValues> {
  @override
  SelectedValues build() {
    _loadTagsAndPreferences();
    return SelectedValues(selected: [], unselected: []);
  }

  void _loadTagsAndPreferences() async {
    try {
      final repo = await ref.read(tweetRepositoryProvider.future);
      final tags = await repo.loadTags();
      final allTags = tags.map((tag) => tag.name).toList();

      // 保存済みの選択タグを読み込み
      final pref = await ref.read(preferencesRepositoryProvider.future);
      final lastSelectedTags = pref.lastSelectedTags;

      final selected =
          lastSelectedTags.where((tag) => allTags.contains(tag)).toList();
      final unselected =
          allTags.where((tag) => !selected.contains(tag)).toList();

      state = SelectedValues(selected: selected, unselected: unselected);
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }

  void initialize(List<String> tags) =>
      state = state.copyWith(unselected: tags);

  bool selectTag(String tag) {
    if (!state.unselected.contains(tag)) return false;
    state = SelectedValues(
      selected: [...state.selected, tag],
      unselected: state.unselected.where((t) => t != tag).toList(),
    );
    _saveSelectedTags();
    return true;
  }

  bool unselectTag(String tag) {
    if (!state.selected.contains(tag)) return false;
    state = SelectedValues(
      selected: state.selected.where((t) => t != tag).toList(),
      unselected: [...state.unselected, tag],
    );
    _saveSelectedTags();
    return true;
  }

  void clearSelection() {
    state = SelectedValues(
      selected: [],
      unselected: [...state.selected, ...state.unselected]..sort(),
    );
    _saveSelectedTags();
  }

  void _saveSelectedTags() async {
    try {
      final pref = await ref.read(preferencesRepositoryProvider.future);
      pref.lastSelectedTags = state.selected;
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }

  Future<bool> addTag(String name) async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    try {
      await repository.addTag(name);
      var tags = [...state.unselected, name];
      tags.sort();
      state = state.copyWith(unselected: tags);
      return true;
    } catch (e) {
      return false;
    }
  }
}

final tagSelectControllerProvider =
    NotifierProvider<TagSelectController, SelectedValues>(
      TagSelectController.new,
    );
