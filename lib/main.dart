import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/tweets/tweets_screen.dart';
import 'features/bin/bin_screen.dart';
import 'features/settings/settings_screen.dart';
import 'providers/theme_mode_controller.dart';
import 'providers/tab_controller.dart';
import 'providers/locale_controller.dart';
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
    ref.watch(localeControllerProvider); // Watch for locale changes
    final localeController = ref.read(localeControllerProvider.notifier);
    final currentLocale = localeController.getEffectiveLocale();

    return MaterialApp(
      title: 'Tweet History',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja', 'JP'), Locale('en', 'US')],
      locale: currentLocale,
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

class _TabConfig {
  final Widget screen;
  final IconData icon;
  final String key;

  const _TabConfig({
    required this.screen,
    required this.icon,
    required this.key,
  });
}

const keyTweets = 'tweets';
const keyBin = 'bin';
const keySettings = 'settings';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  static const List<_TabConfig> _tabConfigs = [
    _TabConfig(screen: TweetsScreen(), icon: Icons.home, key: keyTweets),
    _TabConfig(screen: BinScreen(), icon: Icons.archive, key: keyBin),
    _TabConfig(
      screen: SettingsScreen(),
      icon: Icons.settings,
      key: keySettings,
    ),
  ];

  static final Map<String, String Function(AppLocalizations)> labelDictionary =
      {
        keyTweets: (l) => l.navTweets,
        keyBin: (l) => l.navBin,
        keySettings: (l) => l.navSettings,
      };

  void _onItemTapped(WidgetRef ref, int index) {
    ref.read(tabControllerProvider.notifier).index = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = ref.watch(tabControllerProvider);
    return Scaffold(
      body: _tabConfigs[currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        items:
            _tabConfigs
                .map(
                  (config) => BottomNavigationBarItem(
                    icon: Icon(config.icon),
                    label: labelDictionary[config.key]!(l10n),
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
