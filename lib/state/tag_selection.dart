import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_selection.freezed.dart';

@freezed
abstract class TagSelectionState with _$TagSelectionState {
  const factory TagSelectionState({
    @Default([]) List<String> selected,
    @Default([]) List<String> unselected,
  }) = _TagSelectionState;
}

extension TagSelectionStateX on TagSelectionState {
  List<String> get allTags {
    final all = [...selected, ...unselected];
    all.sort();
    return all;
  }
}
