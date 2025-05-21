import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../../models/tweet.dart';
import '../data/tweet_file_loader.dart';

void showUploadDialog(
  BuildContext context,
  void Function(List<Tweet>) onSuccess,
) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      final theme = Theme.of(context);

      return AlertDialog(
        title: const Text('Upload tweets.js'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ファイルを選択してアップロードしてください。'),
            const SizedBox(height: 12),
            if (kIsWeb)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '⚠ 注意：このアプリはブラウザ上で動作しているため、非常に大きなファイル（例：100MB以上）は読み込めない場合があります。',
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final tweets = await loadTweetsFromFile();
              if (tweets != null) {
                onSuccess(tweets);
              }
            },
            child: const Text('アップロード'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('キャンセル'),
          ),
        ],
      );
    },
  );
}
