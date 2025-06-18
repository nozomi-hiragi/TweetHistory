import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tweet.dart';
import '../providers/tweet_controller.dart';
import '../providers/tweet_select_controller.dart';
import 'tweet_detail_dialog.dart';

class TweetTile extends HookConsumerWidget {
  const TweetTile({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectState = ref.watch(tweetSelectControllerProvider);
    final selectController = ref.read(tweetSelectControllerProvider.notifier);
    final deleted = useRef(false);
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          title: Text(tweet.text),
          subtitle: Text(tweet.createdAt.toString()),
          leading: tweet.media.isNotEmpty
              ? Image.network(
                  tweet.media.first.url,
                  errorBuilder: (context, error, stackTrace) {
                    if (!deleted.value) {
                      deleted.value = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(tweetControllerProvider.notifier)
                            .deleteTweet(tweet.id);
                      });
                    }
                    return const Icon(Icons.broken_image);
                  },
                )
              : null,
          trailing:
              selectState.isSelectionMode
                  ? Checkbox(
                    value: selectState.selectedIds.contains(tweet.id),
                    onChanged: (value) {
                      selectController.toggleSelection(tweet.id);
                    },
                  )
                  : null,
        ),
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
}
