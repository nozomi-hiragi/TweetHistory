import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
    final theme = Theme.of(context);
    final deleted = useRef(false);
    final isSelected = selectState.selectedIds.contains(tweet.id);
    final dateFormat = DateFormat.yMMMd(l10n.localeName).add_Hm();

    // Get tags for this tweet using AsyncValue
    final tweetTagsAsync = ref.watch(tweetTagsProvider(tweet.id));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
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
            child: Container(
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? theme.colorScheme.secondaryContainer.withValues(
                          alpha: 0.3,
                        )
                        : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      isSelected
                          ? theme.colorScheme.secondary.withValues(alpha: 0.4)
                          : theme.colorScheme.outline.withValues(alpha: 0.1),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with date and selection checkbox
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          dateFormat.format(tweet.createdAt),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (selectState.isSelectionMode)
                        Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            selectController.toggleSelection(tweet.id);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tweet content
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Media thumbnail
                      if (tweet.media.isNotEmpty)
                        Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            tweet.media.first.url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              if (!deleted.value) {
                                deleted.value = true;
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
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
                        ),

                      // Tweet text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tweet.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Tags
                            tweetTagsAsync.when(
                              data:
                                  (tags) =>
                                      tags.isNotEmpty
                                          ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 12),
                                              Wrap(
                                                spacing: 6,
                                                runSpacing: 6,
                                                children:
                                                    tags
                                                        .map(
                                                          (tag) =>
                                                              _buildTagChip(
                                                                theme,
                                                                tag,
                                                              ),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                          )
                                          : const SizedBox.shrink(),
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
