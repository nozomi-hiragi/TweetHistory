import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_filter_state.freezed.dart';

@freezed
abstract class PeriodFilterState with _$PeriodFilterState {
  const factory PeriodFilterState({DateTime? since, DateTime? until}) =
      _PeriodFilterState;
}
