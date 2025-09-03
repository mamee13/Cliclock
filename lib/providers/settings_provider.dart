import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings.dart';

class SettingsProvider with ChangeNotifier {
  Settings _settings = Settings.defaultSettings();

  Settings get settings => _settings;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final showSeconds = prefs.getBool('showSeconds') ?? true;
    final showDate = prefs.getBool('showDate') ?? true;
    final theme = prefs.getString('theme') ?? 'light';
    _settings = Settings(
      showSeconds: showSeconds,
      showDate: showDate,
      theme: theme,
    );
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showSeconds', _settings.showSeconds);
    await prefs.setBool('showDate', _settings.showDate);
    await prefs.setString('theme', _settings.theme);
  }

  void toggleShowSeconds() {
    _settings.showSeconds = !_settings.showSeconds;
    saveSettings();
    notifyListeners();
  }

  void toggleShowDate() {
    _settings.showDate = !_settings.showDate;
    saveSettings();
    notifyListeners();
  }

  void setTheme(String theme) {
    _settings.theme = theme;
    saveSettings();
    notifyListeners();
  }
}