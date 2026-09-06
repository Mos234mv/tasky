import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/widgets/custom_svg_picture.dart';
import 'package:todoprof/features/home/home_controller.dart';
import 'package:todoprof/features/add_task/add_task.dart';
import 'package:todoprof/features/home/component/achieved%20tasks.dart';
import 'package:todoprof/features/home/component/high_pirority.dart';
import 'package:todoprof/features/home/component/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),

      child: Consumer<HomeController>(
        builder: (BuildContext context, value, Widget? child) {
          final HomeController controller = context.read<HomeController>();
          return Scaffold(
            floatingActionButton: SizedBox(
              height: 40,
              width: 168,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AddTask();
                      },
                    ),
                  );
                  if (result != null && result == true) {
                    controller.loadTask();
                  }
                },

                label: Text('Add New Task'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: value.userImagePath == null
                                  ? AssetImage(
                                      'assets/Images/Leading element.png',
                                    )
                                  : FileImage(File(value.userImagePath!)),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening , ${value.username}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "One task at a time.One step closer.",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Yuhuu ,Your work Is ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              'almost done !',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(width: 8),
                            CustomSvgPicture(
                              path:
                                  'assets/Images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                              withColor: false,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        AchievedTaskWidget(
                          totalDoneTask: value.totalDoneTask,
                          totalTask: value.totalTask,
                          percentage: value.percentage,
                        ),
                        SizedBox(height: 8),
                        HighPirorityWidget(
                          tasks: value.tasks
                              .where((e) => e.isHighPriority)
                              .toList(),
                          ontap: (bool? val, int? index) {
                            controller.doneTask(val, index);
                          },
                          refresh: () {
                            controller.loadTask();
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          child: Text(
                            "My Tasks",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SliverTaskListWidget(
                    tasks: value.tasks,
                    ontap: (bool? val, int? index) {
                      controller.doneTask(val, index);
                    },
                    onDelete: (int? id) {
                      controller.deleteTask(id);
                    },
                    onedit: () {
                      controller.loadTask();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
