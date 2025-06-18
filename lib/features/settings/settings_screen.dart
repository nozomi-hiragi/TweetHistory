import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/theme_mode_controller.dart';
import '../../providers/user_id_controller.dart';
import '../../providers/locale_controller.dart';
import '../../common/dialogs/user_id_input_dialog.dart';
import 'import_export_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final userId = ref.watch(userIdControllerProvider);
    final currentLanguage = ref.watch(localeControllerProvider);
    final platformDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && platformDark);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (val) {
              ref.read(themeModeControllerProvider.notifier).setDarkMode(val);
            },
          ),
          ListTile(
            title: const Text('Language / 言語'),
            subtitle: Text(currentLanguage.displayName),
            trailing: const Icon(Icons.language),
            onTap: () => _showLanguageDialog(context, ref),
          ),
          ListTile(
            title: const Text('ユーザーID'),
            subtitle: Text(userId?.isNotEmpty == true ? '@$userId' : '未設定'),
            trailing: const Icon(Icons.edit),
            onTap: () => UserIdInputDialog.show(context, initialValue: userId),
          ),
          ListTile(
            title: const Text('Import / Export'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const ImportExportDialog(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    showDialog<SupportedLanguage>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language / 言語を選択'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SupportedLanguage.values.map((language) {
            return RadioListTile<SupportedLanguage>(
              title: Text(language.displayName),
              subtitle: language == SupportedLanguage.system 
                  ? const Text('Follows system settings')
                  : null,
              value: language,
              groupValue: ref.read(localeControllerProvider),
              onChanged: (SupportedLanguage? value) {
                if (value != null) {
                  ref.read(localeControllerProvider.notifier).setLanguage(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel / キャンセル'),
          ),
        ],
      ),
    );
  }
}
