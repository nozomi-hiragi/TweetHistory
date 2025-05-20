import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/tweet.dart';
import '../../providers/tweet_provider.dart';

class TweetsScreen extends ConsumerWidget {
  const TweetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweets = ref.watch(tweetProvider);
    final notifier = ref.read(tweetProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tweets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              notifier.addTweet(
                Tweet(
                  id: DateTime.now().toString(),
                  text: 'New Tweet ${DateTime.now()}',
                  createdAt: DateTime.now(),
                  media: [],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tweets.length,
        itemBuilder: (context, index) {
          final tweet = tweets[index];
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
                notifier.removeTweet(tweet.id);
              },
            ),
          );
        },
      ),
    );
  }
}
