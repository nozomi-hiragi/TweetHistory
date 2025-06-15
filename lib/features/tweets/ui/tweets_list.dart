import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_controller.dart';
import '../../../common/tweet_tile.dart';

const pageNum = 20;

class TweetsList extends HookConsumerWidget {
  const TweetsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showItemNum = useState(pageNum);
    final tweetState = ref.watch(tweetControllerProvider);
    final tweets = tweetState.tweets;

    final ScrollController controller = ScrollController();
    controller.addListener(() {
      if (showItemNum.value >= tweets.length) return;
      if ((controller.offset / controller.position.maxScrollExtent) > 0.99) {
        final newNum = min(showItemNum.value + pageNum, tweets.length);
        showItemNum.value = newNum;
      }
    });

    return ListView.builder(
      controller: controller,
      itemCount: min(tweets.length, showItemNum.value),
      itemBuilder: (context, index) => TweetTile(tweet: tweets[index]),
    );
  }
}
