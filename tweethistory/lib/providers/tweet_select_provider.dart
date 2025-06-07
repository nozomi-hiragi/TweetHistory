import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/tweet_selection.dart';

class TweetSelectNotifier extends Notifier<TweetSelectState> {
  @override
  build() => TweetSelectState();

  void toggle() =>
      state = TweetSelectState(isSelectionMode: !state.isSelectionMode);
}

final selectModeProvider =
    NotifierProvider<TweetSelectNotifier, TweetSelectState>(
      TweetSelectNotifier.new,
    );
