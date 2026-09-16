import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

import 'package:todoprof/core/components/task_list_widget.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';

class CompleteTasks extends StatelessWidget {
  const CompleteTasks({super.key});

  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.pw18),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Consumer<TasksController>(
              builder: (BuildContext context, valueController, Widget? child) {
                return TaskListWidget(
                  tasks: valueController.completeTasks,
                  ontap: (bool? value, int? index) {
                    controller.doneTask(
                      value,
                      valueController.completeTasks[index!].id,
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
        ),
      ],
    );
  }
}
