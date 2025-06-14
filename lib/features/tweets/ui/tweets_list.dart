import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_controller.dart';
import '../../../common/tweet_tile.dart';

class TweetsList extends ConsumerWidget {
  const TweetsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetState = ref.watch(tweetControllerProvider);
    final tweets = tweetState.tweets;
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) => TweetTile(tweet: tweets[index]),
    );
  }
}
