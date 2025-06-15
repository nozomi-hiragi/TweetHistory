import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/tweet_controller.dart';
import '../../../providers/tweet_loader_provider.dart';

class TweetLoaderDialog extends ConsumerWidget {
  const TweetLoaderDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const Text('ファイルを準備しています...'),
                ],
              ),
          data: (state) {
            if (state.progress >= 1) tweetController.addTweets(state.tweets);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: state.progress),
                const SizedBox(height: 16),
                Text('${(state.progress * 100).toInt()}% 完了'),
                const SizedBox(height: 16),
                if (state.progress < 1.0) ...[
                  const Text('ツイートを読み込んでいます...'),
                ] else ...[
                  const Text('読み込みが完了しました！'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('完了'),
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
                  Text('エラー: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('閉じる'),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
