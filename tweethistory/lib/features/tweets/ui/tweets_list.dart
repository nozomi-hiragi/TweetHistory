import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tweet_controller_provider.dart';
import 'tweet_tile.dart';

class TweetsList extends ConsumerWidget {
  const TweetsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetState = ref.watch(tweetControllerProvider);
    final tweetControllerNotifier = ref.read(tweetControllerProvider.notifier);
    final tweets = tweetState.tweets;
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder:
          (context, index) => TweetTile(
            tweet: tweets[index],
            onRemove:
                () => tweetControllerNotifier.removeTweet(tweets[index].id),
          ),
    );
  }
}
