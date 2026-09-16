import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

import 'package:todoprof/features/tasks/tasks_controller.dart';

import 'package:todoprof/core/components/task_list_widget.dart';

class HighPirorityScreen extends StatelessWidget {
  const HighPirorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Scaffold(
      appBar: AppBar(title: Text("High Pirority Tasks")),

      body: Padding(
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Consumer<TasksController>(
          builder:
              (
                BuildContext context,
                TasksController valueController,
                Widget? child,
              ) {
                return TaskListWidget(
                  tasks: valueController.highPirority,
                  ontap: (bool? value, int? index) {
                    controller.doneTask(
                      value,
                      valueController.highPirority[index!].id,
                    );
                  },
                  emptyMessage: "No Tasks Found",
                  onDelete: (int? id) {
                    controller.deleteTask(id);
                  },
                  onedit: () {
                    controller.loadTask();
                  },
                );
              },
        ),
      ),
    );
  }
}
