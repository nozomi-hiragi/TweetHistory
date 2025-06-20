import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../providers/period_filter_provider.dart';
import '../../../../providers/tweet_controller.dart';
import '../../../../providers/locale_controller.dart';
import 'date_chip.dart';

class PeriodFilterSection extends ConsumerWidget {
  const PeriodFilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final periodState = ref.watch(periodFilterProvider);
    final periodController = ref.read(periodFilterProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final localeController = ref.read(localeControllerProvider.notifier);
    final currentLocale = localeController.getEffectiveLocale();
    final dateFormat = DateFormat.yMMMd(currentLocale.languageCode);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.period,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            DateChip(
              label:
                  periodState.since != null
                      ? '${l10n.since}${dateFormat.format(periodState.since!)}'
                      : l10n.selectStartDate,
              isActive: periodState.since != null,
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  locale: currentLocale,
                  initialDate: periodState.since ?? DateTime.now(),
                  firstDate: DateTime(2006),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  periodController.setSince(
                    DateTime(picked.year, picked.month, picked.day),
                  );
                  tweetController.refresh();
                }
              },
              onDeleted:
                  periodState.since != null
                      ? () {
                        periodController.setSince(null);
                        tweetController.refresh();
                      }
                      : null,
            ),
            DateChip(
              label:
                  periodState.until != null
                      ? '${l10n.until}${dateFormat.format(periodState.until!)}'
                      : l10n.selectEndDate,
              isActive: periodState.until != null,
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  locale: currentLocale,
                  initialDate: periodState.until ?? DateTime.now(),
                  firstDate: DateTime(2006),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  periodController.setUntil(
                    DateTime(picked.year, picked.month, picked.day),
                  );
                  tweetController.refresh();
                }
              },
              onDeleted:
                  periodState.until != null
                      ? () {
                        periodController.setUntil(null);
                        tweetController.refresh();
                      }
                      : null,
            ),
          ],
        ),
      ],
    );
  }
}
