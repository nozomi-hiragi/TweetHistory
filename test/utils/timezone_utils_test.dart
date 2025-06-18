import 'package:flutter_test/flutter_test.dart';
import 'package:tweethistory/utils/timezone_utils.dart';

void main() {
  group('parseTimezoneOffset', () {
    test('正のタイムゾーンオフセットを正しくパースする', () {
      final offset = parseTimezoneOffset('+0900');
      expect(offset.inHours, equals(9));
      expect(offset.inMinutes % 60, equals(0));
    });

    test('負のタイムゾーンオフセットを正しくパースする', () {
      final offset = parseTimezoneOffset('-0500');
      expect(offset.inHours, equals(-5));
      expect(offset.inMinutes % 60, equals(0));
    });

    test('時間と分を含むオフセットを正しくパースする', () {
      final offset = parseTimezoneOffset('+0530');
      expect(offset.inHours, equals(5));
      expect(offset.inMinutes % 60, equals(30));
    });
  });

  group('parseTwitterDate', () {
    test('UTCのTwitter日付を正しくパースする', () {
      final date = parseTwitterDate('Wed Aug 23 16:35:51 +0000 2023');
      expect(date.year, equals(2023));
      expect(date.month, equals(8));
      expect(date.day, equals(23));
      expect(date.hour, equals(16));
      expect(date.minute, equals(35));
      expect(date.second, equals(51));
    });

    test('異なるタイムゾーンのTwitter日付を正しくパースする', () {
      final date = parseTwitterDate('Wed Aug 23 16:35:51 +0900 2023');
      expect(date.year, equals(2023));
      expect(date.month, equals(8));
      expect(date.day, equals(23));
      expect(date.hour, equals(7)); // UTCでは7時間前
      expect(date.minute, equals(35));
      expect(date.second, equals(51));
    });

    test('無効な形式の日付で例外をスローする', () {
      expect(
        () => parseTwitterDate('Invalid date format'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
