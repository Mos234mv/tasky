import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/Theme/theme_controller.dart';
import 'package:todoprof/core/constants/app_sizes.dart';
import 'package:todoprof/core/widgets/custom_ceckbox.dart';

import 'package:todoprof/features/tasks/high_pirority_screen.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';

class HighPirorityWidget extends StatelessWidget {
  HighPirorityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizes.r20),
                border: Border.all(
                  color: ThemeController.themeNotifier.value == ThemeMode.light
                      ? Color(0xFFD1DAD6)
                      : Colors.transparent,
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(AppSizes.pw16),
                          child: Text(
                            "High Priority Tasks",
                            style: TextStyle(
                              color: Color(0xFF15B86C),
                              fontSize: AppSizes.sp14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        ...controller.tasks
                            .where((e) => e.isHighPriority)
                            .take(4)
                            .map((elemnt) {
                              return Row(
                                children: [
                                  CustomCeckbox(
                                    value: elemnt.isDone,
                                    onChanged: (value) {
                                      controller.doneTask(value, elemnt.id);
                                    },
                                  ),

                                  Expanded(
                                    child: Text(
                                      elemnt.taskName,
                                      style: elemnt.isDone
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleLarge
                                          : Theme.of(
                                              context,
                                            ).textTheme.titleMedium,

                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HighPirorityScreen();
                          },
                        ),
                      );
                      controller.loadTask();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.pw16),
                      child: Container(
                        padding: EdgeInsets.all(AppSizes.pw8),
                        height: AppSizes.h56,
                        width: AppSizes.w48,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Color(0xFF6E6E6E)
                                : Color(0xFFD1DAD6),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/Images/arrow-up-right.svg',
                          width: AppSizes.w24,
                          height: AppSizes.h24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
