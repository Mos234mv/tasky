import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/Theme/dark_theme.dart';
import 'package:todoprof/core/Theme/light_theme.dart';
import 'package:todoprof/core/Theme/theme_controller.dart';
import 'package:todoprof/core/constants/storage_key.dart';

import 'package:todoprof/core/services/prefrence_manager.dart';

import 'package:todoprof/features/Navigation/main_screen.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';
import 'package:todoprof/features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefrenceManager().init();
  ThemeController().init();
  String? username = PrefrenceManager().getString(StorageKey.userName);
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
        return ChangeNotifierProvider<TasksController>(
          create: (BuildContext context) => TasksController()..init(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TASKY',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: username == null ? Welcome() : MainScreen(),
          ),
        );
      },
    );
  }
}
