import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tweet_controller_provider.dart';
import 'upload_dialog.dart';

class TweetsUploadButton extends ConsumerWidget {
  const TweetsUploadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tweetControllerProvider.notifier);
    return FloatingActionButton(
      key: const ValueKey('fab'),
      onPressed: () {
        showUploadDialog(context, (tweets) {
          notifier.addTweets(tweets);
        });
      },
      tooltip: 'Upload',
      child: const Icon(Icons.add),
    );
  }
}
