import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:web/web.dart' as web;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../providers/user_id_controller.dart';
import 'dialogs/user_id_input_dialog.dart';

class TweetDetailDialog extends ConsumerWidget {
  const TweetDetailDialog({super.key, required this.tweet});

  final Tweet tweet;

  void _openTweetInBrowser(String? userId) {
    final url =
        userId?.isNotEmpty == true
            ? 'https://x.com/$userId/status/${tweet.id}'
            : 'https://x.com/i/status/${tweet.id}';
    web.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm:ss');
    final userId = ref.watch(userIdControllerProvider);

    return AlertDialog(
      title: const Text('ツイート詳細'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tweet text
              SelectableText(
                tweet.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Tweet metadata
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        context,
                        Icons.access_time,
                        '日時',
                        dateFormatter.format(tweet.createdAt),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.favorite,
                        'いいね',
                        tweet.favoriteCount.toString(),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.repeat,
                        'リツイート',
                        tweet.retweetCount.toString(),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.tag,
                        'ID',
                        tweet.id,
                        copyable: true,
                      ),
                    ],
                  ),
                ),
              ),

              // Media section
              if (tweet.media.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('メディア', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ...tweet.media.map((media) => _buildMediaItem(context, media)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        TextButton.icon(
          onPressed: () => UserIdInputDialog.show(context, allowEmpty: false),
          icon: const Icon(Icons.settings),
          label: const Text('ユーザーID設定'),
        ),
        FilledButton.icon(
          onPressed: () => _openTweetInBrowser(userId),
          icon: const Icon(Icons.open_in_new),
          label: const Text('ブラウザで開く'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool copyable = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child:
              copyable
                  ? GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$labelをコピーしました'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                  : Text(value, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }

  Widget _buildMediaItem(BuildContext context, Media media) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                media.url,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 60),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'タイプ: ${media.type}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: media.url));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('メディアURLをコピーしました'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      media.url,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
