// ignore_for_file: dead_code, dead_null_aware_expression, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoprof/features/tasks/complete_task_screen.dart';
import 'package:todoprof/features/home/home_screen.dart';
import 'package:todoprof/features/profile/profile_screen.dart';
import 'package:todoprof/features/tasks/todo_tasks_%20screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screen = [
    HomeScreen(),
    TodoTasksScreen(),
    CompleteTasks(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: _build_svgPicture('assets/Images/Home.svg', 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _build_svgPicture('assets/Images/toDo.svg', 1),
            label: "To DO",
          ),
          BottomNavigationBarItem(
            icon: _build_svgPicture('assets/Images/completed.svg', 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _build_svgPicture('assets/Images/profile.svg', 3),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(child: _screen[_currentIndex]),
    );
  }

  SvgPicture _build_svgPicture(String path, int index) {
    return SvgPicture.asset(
      path,

      colorFilter: ColorFilter.mode(
        _currentIndex == index
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
        BlendMode.srcIn,
      ),
    );
  }
}
