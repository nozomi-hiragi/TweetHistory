import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final SharedPreferences _instance;
  final String _keyThemeMode = 'themeMode';

  const PreferencesRepository._(this._instance);

  static Future<PreferencesRepository> create() async {
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return PreferencesRepository._(instance);
  }

  set themeMode(ThemeMode mode) => _instance.setInt(_keyThemeMode, mode.index);
  ThemeMode get themeMode {
    final index = _instance.getInt(_keyThemeMode);
    return index == null ? ThemeMode.system : ThemeMode.values[index];
  }
}
