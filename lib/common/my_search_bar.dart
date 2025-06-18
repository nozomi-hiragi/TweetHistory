import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/search_query_provider.dart';
import '../providers/sort_order_provider.dart';
import '../providers/tweet_controller.dart';

class MySearchBar extends HookConsumerWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final order = ref.watch(sortOrderProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final controller = useTextEditingController(text: searchQuery);

    // プロバイダーの状態変更をコントローラーに反映
    useEffect(() {
      if (controller.text != searchQuery) {
        controller.text = searchQuery;
      }
      return null;
    }, [searchQuery]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: ref.read(searchQueryProvider.notifier).set,
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              order == SortOrder.newestFirst
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
            ),
            tooltip:
                order == SortOrder.newestFirst
                    ? l10n.sortNewestFirst
                    : l10n.sortOldestFirst,
            onPressed: () {
              ref.read(sortOrderProvider.notifier).toggle();
              ref.read(tweetControllerProvider.notifier).refresh();
            },
          ),
        ],
      ),
    );
  }
}
