import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String name, @Default({}) Set<String> tweetIds}) =
      _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
