import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void setDarkMode(bool isDark) => state = isDark ? ThemeMode.dark : ThemeMode.light;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
