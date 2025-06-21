import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class LlmRatingConfirmDialog extends StatelessWidget {
  final int tweetCount;
  final String filterDescription;

  const LlmRatingConfirmDialog({
    super.key,
    required this.tweetCount,
    required this.filterDescription,
  });

  static Future<bool?> show(
    BuildContext context, {
    required int tweetCount,
    required String filterDescription,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => LlmRatingConfirmDialog(
        tweetCount: tweetCount,
        filterDescription: filterDescription,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.llmRatingStart),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.tweetsWillBeRated(tweetCount)),
          const SizedBox(height: 12),
          Text(l10n.appliedFilters, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(filterDescription, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 12),
          Text(l10n.processingWillTakeTime),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.start),
        ),
      ],
    );
  }
}