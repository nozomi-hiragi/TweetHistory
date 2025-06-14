import 'package:intl/intl.dart';

/// Parses a timezone offset string in the format `+HHMM` or `-HHMM`
/// and returns a [Duration] representing the offset.
/// The hours and minutes are extracted from the string, and the sign
/// is determined by the leading `+` or `-`.
Duration parseTimezoneOffset(String z) {
  if (z.length != 5 || !RegExp(r'^[+-]\d{4}$').hasMatch(z)) {
    throw FormatException('Invalid timezone offset format', z);
  }
  if (z == '+0000' || z == '-0000') {
    return Duration.zero;
  }
  final sign = z.startsWith('-') ? -1 : 1;
  final hours = int.parse(z.substring(1, 3));
  final minutes = int.parse(z.substring(3, 5));
  return Duration(hours: hours * sign, minutes: minutes * sign);
}

DateTime parseTwitterDate(String raw) {
  // Wed Aug 23 16:35:51 +0000 2023
  final match = RegExp(
    r'^(\w+ \w+ \d+ \d+:\d+:\d+) ([+-]\d{4}) (\d{4})$',
  ).firstMatch(raw.trim());

  if (match == null) {
    throw FormatException('Invalid Twitter date format', raw);
  }

  final dateTimeStr = '${match.group(1)} ${match.group(3)}';
  final offsetStr = match.group(2)!;

  final local = DateFormat(
    "EEE MMM dd HH:mm:ss yyyy",
    "en_US",
  ).parseUtc(dateTimeStr);
  final offset = parseTimezoneOffset(offsetStr);

  return local.subtract(offset);
}
