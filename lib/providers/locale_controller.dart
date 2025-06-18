import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SupportedLanguage {
  japanese('ja', 'JP', '日本語'),
  english('en', 'US', 'English'),
  system('system', '', 'System');

  const SupportedLanguage(this.languageCode, this.countryCode, this.displayName);

  final String languageCode;
  final String countryCode;
  final String displayName;

  Locale? get locale {
    if (this == SupportedLanguage.system) return null;
    return Locale(languageCode, countryCode);
  }

  static SupportedLanguage fromLocale(Locale? locale) {
    if (locale == null) return SupportedLanguage.system;
    
    switch (locale.languageCode) {
      case 'ja':
        return SupportedLanguage.japanese;
      case 'en':
        return SupportedLanguage.english;
      default:
        return SupportedLanguage.system;
    }
  }
}

class LocaleController extends Notifier<SupportedLanguage> {
  static const String _prefKey = 'locale_setting';
  SharedPreferences? _prefs;

  @override
  SupportedLanguage build() {
    _loadPreferences();
    return SupportedLanguage.system;
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLanguage = _prefs?.getString(_prefKey);
    
    if (savedLanguage != null) {
      final language = SupportedLanguage.values.firstWhere(
        (lang) => lang.name == savedLanguage,
        orElse: () => SupportedLanguage.system,
      );
      state = language;
    }
  }

  Future<void> setLanguage(SupportedLanguage language) async {
    state = language;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_prefKey, language.name);
  }

  Locale getEffectiveLocale() {
    if (state.locale != null) {
      return state.locale!;
    }
    
    // Get system locale
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    
    // Check if system locale is supported
    if (systemLocale.languageCode == 'ja') {
      return const Locale('ja', 'JP');
    }
    
    // Default to English if system locale is not supported
    return const Locale('en', 'US');
  }
}

final localeControllerProvider = NotifierProvider<LocaleController, SupportedLanguage>(
  () => LocaleController(),
);