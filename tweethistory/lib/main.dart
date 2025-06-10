import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/tweets/tweets_screen.dart';
import 'features/bin/bin_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/tweets/ui/tweets_upload_button.dart';
import 'providers/initialization_provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(initializationProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: initialization.when(
        data: (data) => const MyHomePage(),
        error:
            (error, _) => Scaffold(
              body: Center(child: Text('Initialization failed: $error')),
            ),
        loading:
            () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
      ),
      debugShowCheckedModeBanner: false,
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
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeInBack,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: _index == 0 ? const TweetsUploadButton() : null,
      ),
    );
  }
}
