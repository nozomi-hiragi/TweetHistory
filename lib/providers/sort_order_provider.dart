import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SortOrder { newestFirst, oldestFirst }

class SortOrderNotifier extends Notifier<SortOrder> {
  @override
  SortOrder build() => SortOrder.newestFirst;

  void set(SortOrder order) => state = order;

  void toggle() => state = state == SortOrder.newestFirst
      ? SortOrder.oldestFirst
      : SortOrder.newestFirst;
}

final sortOrderProvider = NotifierProvider<SortOrderNotifier, SortOrder>(
  SortOrderNotifier.new,
);
