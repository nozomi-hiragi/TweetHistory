import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/tweet_selection.dart';
import 'repository_provider.dart';
import 'tweet_controller_provider.dart';

class TweetSelectNotifier extends Notifier<TweetSelectState> {
  @override
  build() => TweetSelectState();

  void toggle() =>
      state = TweetSelectState(isSelectionMode: !state.isSelectionMode);

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
    final repository = ref.read(repositoryProvider).value!;
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;
    final result = await repository.setTag(tagName, selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }

  Future<Set<String>?> removeTag(String tagName) async {
    final repository = ref.read(repositoryProvider).value!;
    final selectedIds = state.selectedIds;
    if (selectedIds.isEmpty) return null;
    final result = await repository.removeTag(tagName, selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }

  Future setBinTag() async {
    final repository = ref.read(repositoryProvider).value!;
    final result = await repository.setBinTag(state.selectedIds);
    ref.read(tweetControllerProvider.notifier).refresh();
    return result;
  }
}

final selectModeProvider =
    NotifierProvider<TweetSelectNotifier, TweetSelectState>(
      TweetSelectNotifier.new,
    );
