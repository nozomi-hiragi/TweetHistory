import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tweet_select_controller.dart';

class TabController extends Notifier<int> {
  @override
  int build() => 0;

  set index(int index) {
    if (state == index) return;
    ref.read(tweetSelectControllerProvider.notifier).endEditMode();
    state = index;
  }
}

final tabControllerProvider = NotifierProvider<TabController, int>(
  TabController.new,
);
