import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/tag_selection.dart';
import 'repository_provider.dart';

class TagSelectionNotifier extends Notifier<TagSelectionState> {
  @override
  TagSelectionState build() {
    final repository = ref.watch(repositoryProvider).value!;
    repository.getTags().then((tags) {
      state = state.copyWith(
        unselected:
            tags.map((tag) {
              return tag.name;
            }).toList(),
      );
    });

    return TagSelectionState(selected: [], unselected: []);
  }

  void initialize(List<String> tags) =>
      state = state.copyWith(unselected: tags);

  bool selectTag(String tag) {
    if (!state.unselected.contains(tag)) return false;
    state = TagSelectionState(
      selected: [...state.selected, tag],
      unselected: state.unselected.where((t) => t != tag).toList(),
    );
    return true;
  }

  bool unselectTag(String tag) {
    if (!state.selected.contains(tag)) return false;
    state = TagSelectionState(
      selected: state.selected.where((t) => t != tag).toList(),
      unselected: [...state.unselected, tag],
    );
    return true;
  }

  Future<bool> addTag(String name) async {
    final repository = ref.watch(repositoryProvider).value!;
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

final tagSelectionProvider =
    NotifierProvider<TagSelectionNotifier, TagSelectionState>(
      TagSelectionNotifier.new,
    );
