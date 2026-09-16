import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/constants/app_sizes.dart';
import 'package:todoprof/core/widgets/custom_svg_picture.dart';
import 'package:todoprof/features/home/home_controller.dart';
import 'package:todoprof/features/add_task/add_task.dart';
import 'package:todoprof/features/home/component/achieved%20tasks.dart';
import 'package:todoprof/features/home/component/high_pirority.dart';
import 'package:todoprof/features/home/component/sliver_task_list_widget.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),

      child: Scaffold(
        floatingActionButton: SizedBox(
          height: AppSizes.h40,
          width: AppSizes.w168,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
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
                    context.read<TasksController>().loadTask();
                  }
                },

                label: Text('Add New Task'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r100),
                ),
              );
            },
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (BuildContext, controller) =>
                              controller.userImagePath,
                          builder:
                              (
                                BuildContext context,
                                String? userImagePath,
                                Widget? child,
                              ) {
                                return CircleAvatar(
                                  backgroundImage: userImagePath == null
                                      ? AssetImage(
                                          'assets/Images/Leading element.png',
                                        )
                                      : FileImage(File(userImagePath)),
                                  radius: AppSizes.r40,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                        ),
                        SizedBox(width: AppSizes.pw8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector: (context, controller) =>
                                    controller.username,
                                builder:
                                    (
                                      BuildContext context,
                                      String? username,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening , $username",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      );
                                    },
                              ),
                              Text(
                                "One task at a time.One step closer.",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.ph16),
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
                        SizedBox(width: AppSizes.pw8),
                        CustomSvgPicture(
                          path:
                              'assets/Images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                          withColor: false,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.ph16),
                    AchievedTaskWidget(),
                    SizedBox(height: AppSizes.ph8),
                    HighPirorityWidget(),

                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.ph24,
                        bottom: AppSizes.ph16,
                      ),
                      child: Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),

              SliverTaskListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
