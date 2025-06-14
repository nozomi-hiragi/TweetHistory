import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  SharedPreferences? _prefs;

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    final index = _prefs!.getInt('themeMode');
    if (index != null) {
      state = ThemeMode.values[index];
    }
  }

  Future<void> _save(ThemeMode mode) async {
    final prefs = _prefs ??= await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _save(mode);
    state = mode;
  }

  Future<void> setDarkMode(bool isDark) =>
      setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
