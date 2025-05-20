import 'package:flutter/material.dart';

import 'features/tweets/tweets_screen.dart';
import 'features/bin/bin_screen.dart';
import 'features/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class _TabItem {
  final Widget screen;
  final IconData icon;
  final String label;

  const _TabItem({
    required this.screen,
    required this.icon,
    required this.label,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  final List<_TabItem> _tabs = [
    const _TabItem(screen: TweetsScreen(), icon: Icons.home, label: 'Tweets'),
    const _TabItem(screen: BinScreen(), icon: Icons.archive, label: 'Bin'),
    const _TabItem(
      screen: SettingsScreen(),
      icon: Icons.settings,
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_index].screen,
      bottomNavigationBar: BottomNavigationBar(
        items:
            _tabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    label: tab.label,
                  ),
                )
                .toList(),
        currentIndex: _index,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Upload',
        child: const Icon(Icons.add),
      ),
    );
  }
}
