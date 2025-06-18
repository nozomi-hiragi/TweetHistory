import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.themeDark),
            value: isDark,
            onChanged: (val) {
              ref.read(themeModeControllerProvider.notifier).setDarkMode(val);
            },
          ),
          ListTile(
            title: Text(l10n.language),
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
            title: Text(l10n.importExport),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog<SupportedLanguage>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SupportedLanguage.values.map((language) {
            return RadioListTile<SupportedLanguage>(
              title: Text(language.displayName),
              subtitle: language == SupportedLanguage.system 
                  ? Text(l10n.languageSystem)
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
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}
