import 'dart:convert';
import '../../../../models/tweet.dart';

String extractJsonArray(String rawJsContent) {
  const prefix = 'window.YTD.tweets.part0 = ';
  final startIndex = rawJsContent.indexOf(prefix);
  if (startIndex == -1) throw Exception('無効なファイル形式です');

  final jsonStart = startIndex + prefix.length;
  final trimmed = rawJsContent.substring(jsonStart).trim();

  return trimmed.endsWith(';')
      ? trimmed.substring(0, trimmed.length - 1)
      : trimmed;
}

List<Tweet> parseTweetsFromJs(String rawJsContent) {
  final jsonStr = extractJsonArray(rawJsContent);
  final List<dynamic> rawList = jsonDecode(jsonStr);
  return rawList.map((json) => Tweet.fromRawJson(json)).toList();
}
