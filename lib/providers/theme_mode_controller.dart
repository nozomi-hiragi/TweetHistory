import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'repository_providers.dart';

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    ref
        .watch(preferencesRepositoryProvider.future)
        .then((repo) => state = repo.themeMode);
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final repo = ref.watch(preferencesRepositoryProvider).value;
    if (repo == null) throw Exception('Repository not initialized');
    repo.themeMode = mode;
    state = mode;
  }

  Future<void> setDarkMode(bool isDark) =>
      setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
}

final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);
