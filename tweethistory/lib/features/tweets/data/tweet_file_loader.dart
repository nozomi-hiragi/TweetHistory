import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../../../models/tweet.dart';
import 'tweet_file_parser.dart';

Future<List<Tweet>?> loadTweetsFromFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['js'],
    withData: true,
  );

  if (result != null && result.files.single.bytes != null) {
    try {
      final bytes = result.files.single.bytes!;
      final content = utf8.decode(bytes);
      final tweets = parseTweetsFromJs(content);
      return tweets;
    } catch (e) {
      print('ツイート読み込みエラー: $e');
    }
  }

  return null;
}
