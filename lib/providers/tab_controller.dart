import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabController extends Notifier<int> {
  @override
  int build() => 0;

  set index(int index) => state = index;
}

final tabControllerProvider = NotifierProvider<TabController, int>(
  TabController.new,
);
