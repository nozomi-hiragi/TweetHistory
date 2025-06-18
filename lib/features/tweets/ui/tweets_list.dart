import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_controller.dart';
import '../../../providers/search_query_provider.dart';
import '../../../common/tweet_tile.dart';

const pageNum = 20;

class TweetsList extends HookConsumerWidget {
  const TweetsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showItemNum = useState(pageNum);
    final tweetState = ref.watch(tweetControllerProvider);
    final query = ref.watch(searchQueryProvider);
    final tweets = query.isEmpty
        ? tweetState.tweets
        : tweetState.tweets
              .where((t) => t.text.toLowerCase().contains(query.toLowerCase()))
              .toList();

    final controller = useScrollController();

    useEffect(() {
      void listener() {
        if (showItemNum.value >= tweets.length) return;
        if ((controller.offset / controller.position.maxScrollExtent) > 0.99) {
          final newNum = min(showItemNum.value + pageNum, tweets.length);
          showItemNum.value = newNum;
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller, tweets.length]);

    useEffect(() {
      showItemNum.value = pageNum;
      if (controller.hasClients) {
        controller.jumpTo(0);
      }
      return null;
    }, [query]);

    return ListView.builder(
      controller: controller,
      itemCount: min(tweets.length, showItemNum.value),
      itemBuilder: (context, index) => TweetTile(tweet: tweets[index]),
    );
  }
}
