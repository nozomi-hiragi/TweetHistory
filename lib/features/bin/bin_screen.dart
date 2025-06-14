import 'package:flutter/material.dart';

import 'ui/binned_list.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bin'),
      ),
      body: BinnedList(),
    );
  }
}
