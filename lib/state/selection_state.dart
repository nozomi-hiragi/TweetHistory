import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_state.freezed.dart';

@freezed
abstract class SelectionState with _$SelectionState {
  const factory SelectionState({
    @Default(false) bool isSelectionMode,
    @Default(<String>{}) Set<String> selectedIds,
  }) = _SelectionState;
}
