import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (val) {
              ref.read(themeModeProvider.notifier).setDarkMode(val);
            },
          ),
          const ListTile(
            title: Text('Import/Export settings (coming soon)'),
          ),
        ],
      ),
    );
  }
}
