import 'package:flutter/material.dart';

import 'ui/binned_list.dart';
import 'ui/bin_app_bar.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BinAppBar(),
      body: BinnedList(),
    );
  }
}
