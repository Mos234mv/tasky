import 'package:flutter/material.dart';
import 'package:todoprof/core/Theme/dark_theme.dart';
import 'package:todoprof/core/Theme/light_theme.dart';
import 'package:todoprof/core/Theme/theme_controller.dart';

import 'package:todoprof/core/services/prefrence_manager.dart';

import 'package:todoprof/screens/main_screen.dart';
import 'package:todoprof/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final pref = await SharedPreferences.getInstance();

  await PrefrenceManager().init();
  ThemeController().init();
  String? username = PrefrenceManager().getString('username');
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.username});
  final String? username;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TASKY App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? Welcome() : MainScreen(),
        );
      },
    );
  }
}
