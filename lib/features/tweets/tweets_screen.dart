import 'package:flutter/material.dart';

import 'ui/app_bar.dart';
import 'ui/tag_filler_bar.dart';
import 'ui/tweets_list.dart';

class TweetsScreen extends StatelessWidget {
  const TweetsScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    appBar: TweetsAppBar(),
    body: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: TagFilterBar(),
        ),
        Expanded(child: TweetsList()),
      ],
    ),
  );
}
