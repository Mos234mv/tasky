// ignore_for_file: empty_statements, strict_top_level_inference, avoid_print

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool result = PrefrenceManager().getBool(StorageKey.theme) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      PrefrenceManager().setBool(StorageKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      PrefrenceManager().setBool(StorageKey.theme, true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
