import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/tweet_loader_provider.dart';
import 'tweet_loader_dialog.dart';
import 'upload_dialog.dart';

class TweetsUploadButton extends ConsumerWidget {
  const TweetsUploadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tweetLoader = ref.read(streamTweetLoaderProvider.notifier);
    return FloatingActionButton(
      key: const ValueKey('fab'),
      onPressed: () async {
        final bytes = await showDialog<Uint8List?>(
          context: context,
          builder: (_) => const UploadDialog(),
        );
        if (bytes == null) return;

        if (!context.mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const TweetLoaderDialog(),
        );
        tweetLoader.load(bytes);
      },
      tooltip: l10n.upload,
      child: const Icon(Icons.add),
    );
  }
}
