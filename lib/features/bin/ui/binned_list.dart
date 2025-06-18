import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/tweet_controller.dart';
import '../../../providers/search_query_provider.dart';
import '../../../common/tweet_tile.dart';

class BinnedList extends HookConsumerWidget {
  const BinnedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetState = ref.watch(tweetControllerProvider);
    final query = ref.watch(searchQueryProvider);
    final tweets = query.isEmpty
        ? tweetState.binned
        : tweetState.binned
              .where((t) => t.text.toLowerCase().contains(query.toLowerCase()))
              .toList();

    final controller = useScrollController();

    useEffect(() {
      if (controller.hasClients) {
        controller.jumpTo(0);
      }
      return null;
    }, [query]);

    return ListView.builder(
      controller: controller,
      itemCount: tweets.length,
      itemBuilder: (context, index) => TweetTile(tweet: tweets[index]),
    );
  }
}
