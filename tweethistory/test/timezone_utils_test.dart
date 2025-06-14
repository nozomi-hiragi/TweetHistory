import 'package:flutter_test/flutter_test.dart';
import 'package:tweethistory/utils/timezone_utils.dart';

void main() {
  group('parseTimezoneOffset', () {
    test('parses positive offsets', () {
      expect(parseTimezoneOffset('+0900'), const Duration(hours: 9));
      expect(parseTimezoneOffset('+0530'), const Duration(hours: 5, minutes: 30));
    });

    test('parses negative offsets', () {
      expect(parseTimezoneOffset('-0400'), const Duration(hours: -4));
      expect(
        parseTimezoneOffset('-0230'),
        const Duration(hours: -2, minutes: -30),
      );
    });

    test('parses zero offset', () {
      expect(parseTimezoneOffset('+0000'), Duration.zero);
    });

    test('throws on invalid format', () {
      expect(() => parseTimezoneOffset('0900'), throwsException);
    });
  });

  group('parseTwitterDate', () {
    test('parses twitter date to UTC', () {
      final date = parseTwitterDate('Wed Aug 23 16:35:51 +0900 2023');
      expect(date.toUtc(), DateTime.utc(2023, 8, 23, 7, 35, 51));
    });
  });
}
