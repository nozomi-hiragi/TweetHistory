import 'package:flutter/material.dart';

import '../../../models/tweet.dart';

class TweetTile extends StatelessWidget {
  const TweetTile({super.key, required this.tweet, required this.onRemove});

  final Tweet tweet;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(tweet.text),
        subtitle: Text(tweet.createdAt.toString()),
        leading:
            tweet.media.isNotEmpty
                ? Image.network(tweet.media.first.url)
                : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
