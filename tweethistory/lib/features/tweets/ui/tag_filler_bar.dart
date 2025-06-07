import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tag_selection_provider.dart';
import '../../../state/tag_selection.dart';

class TagFilterBar extends ConsumerWidget {
  const TagFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagState = ref.watch(tagSelectionProvider);
    final tagController = ref.read(tagSelectionProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children:
            tagState.allTags.map((tag) {
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
                },
              );
            }).toList(),
      ),
    );
  }
}
