import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_values.freezed.dart';

@freezed
abstract class SelectedValues with _$SelectedValues {
  const factory SelectedValues({
    @Default([]) List<String> selected,
    @Default([]) List<String> unselected,
  }) = _SelectedValues;
}

extension SelectedValuesX on SelectedValues {
  List<String> get values => [...selected, ...unselected]..sort();
}
