import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/period_filter_state.dart';

class PeriodFilterController extends Notifier<PeriodFilterState> {
  @override
  PeriodFilterState build() => const PeriodFilterState();

  void setSince(DateTime? since) => state = state.copyWith(since: since);
  void setUntil(DateTime? until) => state = state.copyWith(until: until);
}

final periodFilterProvider =
    NotifierProvider<PeriodFilterController, PeriodFilterState>(
      PeriodFilterController.new,
    );
