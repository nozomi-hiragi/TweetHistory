import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/period_filter_state.dart';
import 'repository_providers.dart';

class PeriodFilterController extends Notifier<PeriodFilterState> {
  @override
  PeriodFilterState build() {
    // 起動時に保存済みの期間フィルターを非同期で読み込み
    _loadSavedPeriod();
    return const PeriodFilterState();
  }

  void _loadSavedPeriod() async {
    try {
      final pref = await ref.read(preferencesRepositoryProvider.future);
      final since = pref.lastPeriodSince;
      final until = pref.lastPeriodUntil;
      if (since != null || until != null) {
        state = PeriodFilterState(since: since, until: until);
      }
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }

  void setSince(DateTime? since) {
    state = state.copyWith(since: since);
    _savePeriod();
  }

  void setUntil(DateTime? until) {
    state = state.copyWith(until: until);
    _savePeriod();
  }

  void setPeriod({DateTime? since, DateTime? until}) {
    state = state.copyWith(since: since, until: until);
    _savePeriod();
  }

  void _savePeriod() async {
    try {
      final pref = await ref.read(preferencesRepositoryProvider.future);
      pref.lastPeriodSince = state.since;
      pref.lastPeriodUntil = state.until;
    } catch (e) {
      // エラーが発生した場合は無視
    }
  }
}

final periodFilterProvider =
    NotifierProvider<PeriodFilterController, PeriodFilterState>(
      PeriodFilterController.new,
    );
