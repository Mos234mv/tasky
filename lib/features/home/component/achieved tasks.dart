import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/Theme/theme_controller.dart';

import 'package:todoprof/features/tasks/tasks_controller.dart';

class AchievedTaskWidget extends StatelessWidget {
  AchievedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController value, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ThemeController.isDark()
                  ? Colors.transparent
                  : Color(0xFFD1DAD6),
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achieved Tasks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  Text(
                    "${value.totalDoneTask} Out of ${value.totalTask} Done",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF15B86C),
                      ),
                      value: value.percentage,
                      strokeWidth: 4,
                      strokeAlign: 3,
                    ),
                  ),
                  Text(
                    "${(value.percentage * 100).toInt()} %",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
