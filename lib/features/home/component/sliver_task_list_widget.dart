// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoprof/core/components/task_item_widget.dart';
import 'package:todoprof/features/home/home_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(value: 20)),
                  )
                : controller.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No Data",
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(fontSize: 24),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),

                    sliver: SliverList.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TaskItemWidget(
                            model: controller.tasks[index],
                            onChanged: (bool? value) {
                              controller.doneTask(value, index);
                            },
                            onDelete: (int id) {
                              controller.deleteTask(id);
                            },
                            onedit: () {
                              controller.loadTask();
                            },
                          ),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
