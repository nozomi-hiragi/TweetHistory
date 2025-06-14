import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_controller.dart';
import '../../tweets/ui/tweet_tile.dart';

class BinnedList extends ConsumerWidget {
  const BinnedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetState = ref.watch(tweetControllerProvider);
    final tweets = tweetState.binned;
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) => TweetTile(tweet: tweets[index]),
    );
  }
}
