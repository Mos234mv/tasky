// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoprof/core/components/task_item_widget.dart';

import 'package:todoprof/features/tasks/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (
            BuildContext context,
            TasksController valueController,
            Widget? child,
          ) {
            return valueController.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(value: 20)),
                  )
                : valueController.tasks.isEmpty
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
                      itemCount: valueController.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TaskItemWidget(
                            model: valueController.tasks[index],
                            onChanged: (bool? value) {
                              valueController.doneTask(
                                value,
                                valueController.tasks[index].id,
                              );
                            },
                            onDelete: (int id) {
                              valueController.deleteTask(id);
                            },
                            onedit: () {
                              valueController.loadTask();
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
