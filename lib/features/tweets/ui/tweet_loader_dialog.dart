import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/tweet_controller.dart';
import '../../../providers/tweet_loader_provider.dart';

class TweetLoaderDialog extends ConsumerWidget {
  const TweetLoaderDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final loaderState = ref.watch(streamTweetLoaderProvider);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: loaderState.when(
          loading:
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.preparingFile),
                ],
              ),
          data: (state) {
            if (state.progress >= 1) tweetController.addTweets(state.tweets);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: state.progress),
                const SizedBox(height: 16),
                Text(l10n.percentComplete((state.progress * 100).toInt())),
                const SizedBox(height: 16),
                if (state.progress < 1.0) ...[
                  Text(l10n.loadingTweets),
                ] else ...[
                  Text(l10n.loadingComplete),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.done),
                  ),
                ],
              ],
            );
          },
          error:
              (error, _) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text('${l10n.error}: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.close),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
