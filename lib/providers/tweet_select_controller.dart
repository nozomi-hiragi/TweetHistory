import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tag.dart';
import '../repository/tweet_repository.dart';
import '../state/selection_state.dart';
import 'repository_providers.dart';
import 'tweet_controller.dart';

class TweetSelectController extends Notifier<SelectionState> {
  @override
  build() => SelectionState();

  void toggleEditMode() {
    final newMode =
        state.mode == SelectionMode.edit
            ? SelectionMode.normal
            : SelectionMode.edit;
    state = SelectionState(mode: newMode);
  }

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
    final repository = await ref.read(tweetRepositoryProvider.future);
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;

    final result = await repository.loadTag(tagName).then((tag) {
      if (tag == null) return null;
      return repository.saveTag(
        tag.copyWith(tweetIds: {...tag.tweetIds, ...selectedIds}),
      );
    });

    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }

  Future<Set<String>?> removeTag(String tagName) async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;

    final result = await repository.loadTag(tagName).then((tag) {
      if (tag == null) return null;
      return repository.removeIdsFromTag(tag, selectedIds);
    });

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
    state = SelectionState(mode: SelectionMode.normal);
    return failedTagNames;
  }

  Future setBinTag() async {
    final repository = await ref.read(tweetRepositoryProvider.future);

    Tag? tmpBinTag;
    final ids = state.selectedIds;
    final tags = await repository.loadAllTags();
    final futures = <Future<Set<String>?>>[];
    for (var tag in tags) {
      if (tag.name == tagNameBin) {
        tmpBinTag = tag;
      } else if (tag.tweetIds.any(ids.contains)) {
        futures.add(repository.removeIdsFromTag(tag, ids));
      }
    }
    final binTag =
        tmpBinTag == null
            ? Tag(name: tagNameBin, tweetIds: ids)
            : tmpBinTag.copyWith(tweetIds: {...tmpBinTag.tweetIds, ...ids});
    final result = await Future.wait(
      futures..add(repository.saveTag(binTag)),
    ).then((v) => v.last);

    ref.read(tweetControllerProvider.notifier).refresh();
    state = SelectionState(mode: SelectionMode.normal);
    return result;
  }

  Future<bool> deleteTweets() async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    final ids = state.selectedIds;
    if (ids.isEmpty) return false;
    await repository.deleteTweets(ids);
    state = SelectionState(mode: SelectionMode.normal);
    ref.read(tweetControllerProvider.notifier).refresh();
    return true;
  }

  Future<bool> restoreTweets() async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    final ids = state.selectedIds;
    if (ids.isEmpty) return false;
    await repository.restoreTweets(ids);
    state = SelectionState(mode: SelectionMode.normal);
    ref.read(tweetControllerProvider.notifier).refresh();
    return true;
  }

  Future<Map<String, bool?>> getTagSelectionStatus() async {
    final repository = await ref.read(tweetRepositoryProvider.future);
    final tags = await repository.loadTags();
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

final tweetSelectControllerProvider =
    NotifierProvider<TweetSelectController, SelectionState>(
      TweetSelectController.new,
    );
