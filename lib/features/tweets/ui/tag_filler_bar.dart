import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/tag_select_controller.dart';
import '../../../providers/tweet_controller.dart';
import '../../../providers/period_filter_provider.dart';
import '../../../state/selected_values.dart';
import '../../../common/dialogs/add_tag_dialog.dart';

class TagFilterBar extends ConsumerWidget {
  const TagFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectControllerProvider);
    final tagController = ref.read(tagSelectControllerProvider.notifier);
    final tweetController = ref.read(tweetControllerProvider.notifier);
    final periodState = ref.watch(periodFilterProvider);
    final periodController = ref.read(periodFilterProvider.notifier);
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              InputChip(
                label: Text(
                  periodState.since != null
                      ? 'since: ${dateFormat.format(periodState.since!)}'
                      : 'since',
                ),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
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
              InputChip(
                label: Text(
                  periodState.until != null
                      ? 'until: ${dateFormat.format(periodState.until!)}'
                      : 'until',
                ),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
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
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              ...tagState.values.map((tag) {
                final isSelected = tagState.selected.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (_) {
                    if (isSelected) {
                      tagController.unselectTag(tag);
                    } else {
                      tagController.selectTag(tag);
                    }
                    tweetController.refresh();
                  },
                );
              }),
              ActionChip(
                label: const Icon(Icons.add),
                tooltip: 'Add tag',
                onPressed: () async {
                  final newTag = await AddTagDialog.show(context);
                  if (newTag != null && newTag.isNotEmpty) {
                    tagController.addTag(newTag);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
