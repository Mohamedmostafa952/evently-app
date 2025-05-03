import 'package:flutter/material.dart';

// observable
class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  bool get isDark => currentTheme == ThemeMode.dark;

  String currentLang = "en";

  bool get isEnglish => currentLang == "en";

  void changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    // if the new theme is light (contain the same value in current theme), so we don't have to change theme (data)
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLang(String newLang) {
    if (currentLang == newLang) return;

    currentLang = newLang;
    notifyListeners();
  }
}
