import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:web/web.dart' as web;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../providers/user_id_controller.dart';
import '../providers/tweet_controller.dart';
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

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.confirmDeleteTweet),
            content: Text(l10n.deleteTweetWarning),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.delete),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await ref.read(tweetControllerProvider.notifier).deleteTweet(tweet.id);
        if (context.mounted) {
          Navigator.of(context).pop(); // Close detail dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.tweetsDeletedSuccess),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.tweetsDeletedError),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormatter = DateFormat.yMd(l10n.localeName).add_Hms();
    final userId = ref.watch(userIdControllerProvider);

    return AlertDialog(
      title: Text(l10n.tweetDetails),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Reply/Retweet indicator
              if (tweet.isReply || tweet.isRetweet) ...[
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        if (tweet.isReply) ...[
                          Icon(
                            Icons.reply,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tweet.inReplyToScreenName != null
                                ? '${l10n.replyTo} @${tweet.inReplyToScreenName}'
                                : l10n.reply,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (tweet.isReply && tweet.isRetweet) 
                          const SizedBox(width: 16),
                        if (tweet.isRetweet) ...[
                          Icon(
                            Icons.repeat,
                            size: 20,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tweet.retweetedUserScreenName != null
                                ? '${l10n.retweetFrom} @${tweet.retweetedUserScreenName}'
                                : l10n.retweet,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

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
                        l10n.postedAt,
                        dateFormatter.format(tweet.createdAt),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.favorite,
                        l10n.favoriteCount,
                        tweet.favoriteCount.toString(),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.repeat,
                        l10n.retweetCount,
                        tweet.retweetCount.toString(),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        Icons.tag,
                        l10n.tweetId,
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
                Text(l10n.media, style: Theme.of(context).textTheme.titleSmall),
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
          child: Text(l10n.close),
        ),
        TextButton.icon(
          onPressed: () => UserIdInputDialog.show(context, allowEmpty: false),
          icon: const Icon(Icons.settings),
          label: Text(l10n.userIdSetting),
        ),
        TextButton.icon(
          onPressed: () => _showDeleteConfirmation(context, ref),
          icon: const Icon(Icons.delete),
          label: Text(l10n.deleteThisTweet),
        ),
        FilledButton.icon(
          onPressed: () => _openTweetInBrowser(userId),
          icon: const Icon(Icons.open_in_new),
          label: Text(l10n.openInBrowser),
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
    final l10n = AppLocalizations.of(context)!;
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
                          content: Text(l10n.copiedToClipboard(label)),
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
    final l10n = AppLocalizations.of(context)!;
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
                    '${l10n.type}: ${media.type}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: media.url));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.mediaUrlCopied),
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
