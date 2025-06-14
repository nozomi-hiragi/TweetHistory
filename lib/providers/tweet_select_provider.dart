import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/selection_state.dart';
import 'repository_provider.dart';
import 'tweet_controller_provider.dart';

class TweetSelectNotifier extends Notifier<SelectionState> {
  @override
  build() => SelectionState();

  void toggle() =>
      state = SelectionState(isSelectionMode: !state.isSelectionMode);

  bool toggleSelection(String tweetId) {
    final selectedIds = Set<String>.from(state.selectedIds);
    final isSelected = selectedIds.contains(tweetId);
    if (isSelected) {
      selectedIds.remove(tweetId);
    } else {
      selectedIds.add(tweetId);
    }
    state = state.copyWith(selectedIds: selectedIds);
    return !isSelected;
  }

  Future<Set<String>?> applyTag(String tagName) async {
    final repository = await ref.read(repositoryProvider.future);
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;
    final result = await repository.setTag(tagName, selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }

  Future<Set<String>?> removeTag(String tagName) async {
    final repository = await ref.read(repositoryProvider.future);
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;
    final result = await repository.removeTag(tagName, selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }

  Future<Set<String>> applyTags(Map<String, bool?> selectedTags) async {
    final failedTagNames = <String>{};
    await Future.wait(
      selectedTags.entries.map((e) async {
        final fn =
            e.value == true
                ? applyTag
                : e.value == false
                ? removeTag
                : (_) async => null;
        return fn(e.key).then((res) {
          if (res == null) failedTagNames.add(e.key);
        });
      }),
    );
    state = SelectionState(isSelectionMode: false);
    return failedTagNames;
  }

  Future setBinTag() async {
    final repository = await ref.read(repositoryProvider.future);
    final result = await repository.setBinTag(state.selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    state = SelectionState(isSelectionMode: false);
    return result;
  }

  Future<Map<String, bool?>> getTagSelectionStatus() async {
    final repository = await ref.read(repositoryProvider.future);
    final tags = await repository.getTags();
    final ids = state.selectedIds;
    final idsLength = ids.length;
    final Map<String, bool?> tagStatus = {
      for (final tag in tags)
        tag.name:
            (() {
              final count = ids
                  .map((id) => tag.tweetIds.contains(id) ? 1 : 0)
                  .fold(0, (a, b) => a + b);
              return count <= 0
                  ? false
                  : count >= idsLength
                  ? true
                  : null;
            })(),
    };
    return tagStatus;
  }
}

final selectModeProvider =
    NotifierProvider<TweetSelectNotifier, SelectionState>(
      TweetSelectNotifier.new,
    );
