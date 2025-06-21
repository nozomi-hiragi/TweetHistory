import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/repository_providers.dart';
import '../../providers/tweet_controller.dart';
import '../../utils/llm_rating.dart';
import '../../l10n/app_localizations.dart';

class LlmRatingProgressDialog extends HookConsumerWidget {
  final List<dynamic> tweets;

  const LlmRatingProgressDialog({super.key, required this.tweets});

  static void show(BuildContext context, {required List<dynamic> tweets}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LlmRatingProgressDialog(tweets: tweets),
    );
  }

  Future<void> _processTweets(
    WidgetRef ref,
    BuildContext context,
    ValueNotifier<int> processedCount,
    ValueNotifier<bool> isCompleted,
    ValueNotifier<bool> isInitializing,
    List<Duration> recentProcessingTimes,
    ValueNotifier<DateTime?> lastProcessTime,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final ratingTagNames = [
      l10n.ratingTagKeep,
      l10n.ratingTagLowRisk,
      l10n.ratingTagMediumRisk,
      l10n.ratingTagHighRisk,
    ];
    try {
      // Ollama初期化処理
      isInitializing.value = true;
      try {
        await rateTweetText("1+1=");
      } catch (e) {
        // 初期化エラーは無視
      }
      isInitializing.value = false;

      final repository = await ref.read(tweetRepositoryProvider.future);
      lastProcessTime.value = DateTime.now();

      for (int i = 0; i < tweets.length; i++) {
        final tweet = tweets[i];
        final rating = await rateTweetText(tweet.text);

        if (rating != null) {
          String tagName;
          if (rating >= 8) {
            tagName = ratingTagNames[3]; // 高リスク
          } else if (rating >= 5) {
            tagName = ratingTagNames[2]; // 中リスク
          } else if (rating >= 3) {
            tagName = ratingTagNames[1]; // 低リスク
          } else {
            tagName = ratingTagNames[0]; // 保持推奨
          }

          try {
            var tag = await repository.loadTag(tagName);
            if (tag == null) {
              await repository.addTag(tagName);
              tag = await repository.loadTag(tagName);
            }
            if (tag != null) {
              await repository.saveTag(
                tag.copyWith(tweetIds: {...tag.tweetIds, tweet.id}),
              );
            }
          } catch (e) {
            // タグ付けエラーは無視して続行
          }
        }

        // 処理時間を記録（移動平均用）
        final now = DateTime.now();
        if (lastProcessTime.value != null) {
          final processingTime = now.difference(lastProcessTime.value!);
          recentProcessingTimes.add(processingTime);

          // 最新の5件のみ保持
          if (recentProcessingTimes.length > 5) {
            recentProcessingTimes.removeAt(0);
          }
        }
        lastProcessTime.value = now;

        processedCount.value = i + 1;
      }

      ref.read(tweetControllerProvider.notifier).refresh();
      isCompleted.value = true;

      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.llmRatingComplete)));
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.llmRatingError(e.toString()))),
        );
      }
    }
  }

  String _formatRemainingTime(Duration duration, AppLocalizations l10n) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return l10n.remainingTimeMinutes(minutes, seconds);
    } else {
      return l10n.remainingTimeSeconds(seconds);
    }
  }

  Duration? _calculateRemainingTime(
    List<Duration> recentProcessingTimes,
    int processedCount,
  ) {
    if (recentProcessingTimes.isEmpty || processedCount == 0) {
      return null;
    }

    // 移動平均を計算
    final totalMs = recentProcessingTimes
        .map((d) => d.inMilliseconds)
        .reduce((a, b) => a + b);
    final avgMs = totalMs / recentProcessingTimes.length;

    // 残り件数
    final remainingCount = tweets.length - processedCount;
    if (remainingCount <= 0) return null;

    // 推定残り時間
    final remainingMs = (avgMs * remainingCount).round();
    return Duration(milliseconds: remainingMs);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final processedCount = useState(0);
    final isCompleted = useState(false);
    final isInitializing = useState(true);
    final recentProcessingTimes = useState<List<Duration>>([]);
    final lastProcessTime = useState<DateTime?>(null);

    useEffect(() {
      _processTweets(
        ref,
        context,
        processedCount,
        isCompleted,
        isInitializing,
        recentProcessingTimes.value,
        lastProcessTime,
      );
      return null;
    }, []);

    final progress =
        tweets.isNotEmpty ? processedCount.value / tweets.length : 0.0;
    final remainingTime = _calculateRemainingTime(
      recentProcessingTimes.value,
      processedCount.value,
    );

    return AlertDialog(
      title: Text(
        isInitializing.value ? l10n.llmInitializing : l10n.llmRatingInProgress,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isInitializing.value) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.llmWaiting),
          ] else ...[
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 16),
            Text('${processedCount.value} / ${tweets.length}'),
            if (remainingTime != null && !isCompleted.value) ...[
              const SizedBox(height: 8),
              Text(
                _formatRemainingTime(remainingTime, l10n),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (isCompleted.value) ...[
              const SizedBox(height: 8),
              Text(l10n.done),
            ],
          ],
        ],
      ),
      actions:
          isCompleted.value
              ? [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.close),
                ),
              ]
              : null,
    );
  }
}
