import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/theme_mode_controller.dart';
import '../../providers/user_id_controller.dart';
import '../../common/dialogs/user_id_input_dialog.dart';
import 'import_export_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final userId = ref.watch(userIdControllerProvider);
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
}
