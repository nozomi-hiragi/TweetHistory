import 'package:flutter/material.dart';

import 'ui/app_bar/app_bar.dart';
import 'ui/filter_section/filter_section.dart';
import 'ui/tweets_list.dart';

class TweetsScreen extends StatelessWidget {
  const TweetsScreen({super.key});

  static const _appBar = TweetsAppBar();
  static const _filterSection = FilterSection();
  static const _tweetsList = TweetsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth >= 768;

          if (isWideScreen) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 320,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(child: _filterSection),
                  ),
                ),
                Expanded(child: _tweetsList),
              ],
            );
          } else {
            return const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _filterSection,
                ),
                Expanded(child: _tweetsList),
              ],
            );
          }
        },
      ),
    );
  }
}
