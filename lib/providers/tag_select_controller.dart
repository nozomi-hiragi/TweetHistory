import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/selected_values.dart';
import 'repository_providers.dart';

class TagSelectController extends Notifier<SelectedValues> {
  @override
  SelectedValues build() {
    ref.read(tweetRepositoryProvider.future).then((repo) async {
      final tags = await repo.getTags();
      state = state.copyWith(unselected: tags.map((tag) => tag.name).toList());
    });
    return SelectedValues(selected: [], unselected: []);
  }

  void initialize(List<String> tags) =>
      state = state.copyWith(unselected: tags);

  bool selectTag(String tag) {
    if (!state.unselected.contains(tag)) return false;
    state = SelectedValues(
      selected: [...state.selected, tag],
      unselected: state.unselected.where((t) => t != tag).toList(),
    );
    return true;
  }

  bool unselectTag(String tag) {
    if (!state.selected.contains(tag)) return false;
    state = SelectedValues(
      selected: state.selected.where((t) => t != tag).toList(),
      unselected: [...state.unselected, tag],
    );
    return true;
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
