import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/tweet_type_filter_provider.dart';
import '../../../../providers/tweet_controller.dart';

class TweetTypeFilterSection extends ConsumerWidget {
  const TweetTypeFilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final typeState = ref.watch(tweetTypeFilterProvider);
    final typeController = ref.read(tweetTypeFilterProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.type,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            FilterChip(
              label: Text(l10n.reply),
              selected: typeState.showReplies,
              onSelected: (selected) async {
                await typeController.setShowReplies(selected);
                tweetController.refresh();
              },
              avatar: Icon(
                Icons.reply,
                size: 16,
                color:
                    typeState.showReplies
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.primary,
              ),
            ),
            FilterChip(
              label: Text(l10n.retweet),
              selected: typeState.showRetweets,
              onSelected: (selected) async {
                await typeController.setShowRetweets(selected);
                tweetController.refresh();
              },
              avatar: Icon(
                Icons.repeat,
                size: 16,
                color:
                    typeState.showRetweets
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.tertiary,
              ),
            ),
            FilterChip(
              label: Text(l10n.regularTweet),
              selected: typeState.showRegular,
              onSelected: (selected) async {
                await typeController.setShowRegular(selected);
                tweetController.refresh();
              },
              avatar: Icon(
                Icons.chat_bubble_outline,
                size: 16,
                color:
                    typeState.showRegular
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
