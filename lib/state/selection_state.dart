import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection_state.freezed.dart';

enum SelectionMode { normal, edit }

@freezed
abstract class SelectionState with _$SelectionState {
  const factory SelectionState({
    @Default(SelectionMode.normal) SelectionMode mode,
    @Default(<String>{}) Set<String> selectedIds,
  }) = _SelectionState;

  const SelectionState._();

  bool get isEditMode => mode == SelectionMode.edit;
}
