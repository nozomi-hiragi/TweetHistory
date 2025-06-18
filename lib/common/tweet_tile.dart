import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/tweet.dart';
import '../providers/tweet_controller.dart';
import '../providers/tweet_select_controller.dart';
import '../providers/repository_providers.dart';
import 'tweet_detail_dialog.dart';

// Provider to get tags for a specific tweet
final tweetTagsProvider = FutureProvider.family<List<String>, String>((
  ref,
  tweetId,
) async {
  final repository = await ref.read(tweetRepositoryProvider.future);
  final allTags = await repository.loadAllTags();
  return allTags
      .where((tag) => tag.name != 'bin' && tag.tweetIds.contains(tweetId))
      .map((tag) => tag.name)
      .toList();
});

class TweetTile extends HookConsumerWidget {
  const TweetTile({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectState = ref.watch(tweetSelectControllerProvider);
    final selectController = ref.read(tweetSelectControllerProvider.notifier);
    final tweetTagsAsync = ref.watch(tweetTagsProvider(tweet.id));
    final theme = Theme.of(context);
    final deleted = useRef(false);
    final isSelected = selectState.selectedIds.contains(tweet.id);
    final dateFormat = DateFormat.yMd(l10n.localeName).add_Hm();

    return InkWell(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tweet text
            Text(
              tweet.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),

            // Media thumbnail
            Row(
              children:
                  tweet.media.map((media) {
                    return Container(
                      width: 240,
                      height: 240,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        media.url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          if (!deleted.value) {
                            deleted.value = true;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ref
                                  .read(tweetControllerProvider.notifier)
                                  .deleteTweet(tweet.id);
                            });
                          }
                          return Icon(
                            Icons.broken_image,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 24,
                          );
                        },
                      ),
                    );
                  }).toList(),
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  tweet.favoriteCount.toString(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.repeat,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  tweet.retweetCount.toString(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tweetTagsAsync.when(
              data: (tags) {
                if (tags.isEmpty) return const SizedBox.shrink();
                return Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      tags.map((tag) => _buildTagChip(theme, tag)).toList(),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            Text(
              dateFormat.format(tweet.createdAt),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing:
            selectState.isSelectionMode
                ? Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    selectController.toggleSelection(tweet.id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
                : null,
      ),
      onTap: () {
        if (selectState.isSelectionMode) {
          selectController.toggleSelection(tweet.id);
        } else {
          showDialog(
            context: context,
            builder: (_) => TweetDetailDialog(tweet: tweet),
          );
        }
      },
    );
  }

  Widget _buildTagChip(ThemeData theme, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }
}
