import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/tweets/tweets_screen.dart';
import 'features/bin/bin_screen.dart';
import 'features/settings/settings_screen.dart';
import 'providers/theme_mode_controller.dart';
import 'providers/tab_controller.dart';
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
    final themeMode = ref.watch(themeModeControllerProvider);
    return MaterialApp(
      title: 'Tweet History',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
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

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  static const List<_TabItem> _tabs = [
    _TabItem(screen: TweetsScreen(), icon: Icons.home, label: 'Tweets'),
    _TabItem(screen: BinScreen(), icon: Icons.archive, label: 'Bin'),
    _TabItem(
      screen: SettingsScreen(),
      icon: Icons.settings,
      label: 'Settings',
    ),
  ];

  void _onItemTapped(WidgetRef ref, int index) {
    ref.read(tabControllerProvider.notifier).setTabIndex(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabControllerProvider);
    return Scaffold(
      body: _tabs[currentIndex].screen,
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
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(ref, index),
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
        child: currentIndex == 0 ? const TweetsUploadButton() : null,
      ),
    );
  }
}
