import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/tag_selection.dart';

class TagSelectionNotifier extends Notifier<TagSelectionState> {
  @override
  TagSelectionState build() {
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
}

final tagSelectionProvider =
    NotifierProvider<TagSelectionNotifier, TagSelectionState>(
      TagSelectionNotifier.new,
    );
