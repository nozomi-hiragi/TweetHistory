import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tweet_controller_provider.dart';

class TweetsScreen extends ConsumerWidget {
  const TweetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetState = ref.watch(tweetControllerProvider);
    final controller = ref.read(tweetControllerProvider.notifier);

    return tweetState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('エラー: $e')),
      data: (state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Tweets'),
          ),
          body: ListView.builder(
            itemCount: state.tweets.length,
            itemBuilder: (context, index) {
              final tweet = state.tweets[index];
              return ListTile(
                title: Text(tweet.text),
                subtitle: Text(tweet.createdAt.toString()),
                leading:
                    tweet.media.isNotEmpty
                        ? Image.network(tweet.media.first.url)
                        : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.removeTweet(tweet.id);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
