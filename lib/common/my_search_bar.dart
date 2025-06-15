import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/search_query_provider.dart';
import '../providers/sort_order_provider.dart';
import '../providers/tweet_controller.dart';

class MySearchBar extends ConsumerWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(sortOrderProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: ref.read(searchQueryProvider.notifier).set,
              decoration: const InputDecoration(
                hintText: '検索',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          PopupMenuButton<SortOrder>(
            icon: const Icon(Icons.sort),
            onSelected: (order) {
              ref.read(sortOrderProvider.notifier).set(order);
              ref.read(tweetControllerProvider.notifier).refresh();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: SortOrder.newestFirst, child: Text('新しい順')),
              PopupMenuItem(value: SortOrder.oldestFirst, child: Text('古い順')),
            ],
            tooltip: order == SortOrder.newestFirst ? '新しい順' : '古い順',
          ),
        ],
      ),
    );
  }
}
