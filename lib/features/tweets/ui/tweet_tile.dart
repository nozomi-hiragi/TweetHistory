import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/tweet.dart';
import '../../../providers/tweet_select_controller.dart';

class TweetTile extends ConsumerWidget {
  const TweetTile({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectState = ref.watch(tweetSelectControllerProvider);
    final selectController = ref.read(tweetSelectControllerProvider.notifier);
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          title: Text(tweet.text),
          subtitle: Text(tweet.createdAt.toString()),
          leading:
              tweet.media.isNotEmpty
                  ? Image.network(tweet.media.first.url)
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
        }
      },
    );
  }
}
