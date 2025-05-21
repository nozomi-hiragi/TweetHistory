import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tweet_provider.dart';
import 'upload_dialog.dart';

class TweetsUploadButton extends ConsumerWidget {
  const TweetsUploadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tweetProvider.notifier);
    return FloatingActionButton(
      key: const ValueKey('fab'),
      onPressed: () {
        showUploadDialog(context, (tweets) {
          notifier.addAll(tweets);
        });
      },
      tooltip: 'Upload',
      child: const Icon(Icons.add),
    );
  }
}
