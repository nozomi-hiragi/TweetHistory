import 'package:flutter/material.dart';

class TweetsScreen extends StatelessWidget {
  const TweetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tweets'),
      ),
      body: const Center(child: Text('ここにツイート一覧が表示されます')),
    );
  }
}
