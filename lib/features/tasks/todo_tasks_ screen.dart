import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoprof/features/add_task/add_task_controller.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/core/components/task_list_widget.dart';

class TodoTasksScreen extends StatelessWidget {
  TodoTasksScreen({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "To Do Tasks",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer<TasksController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return TaskListWidget(
                      tasks: value.todoTasks,
                      ontap: (bool? value, int? index) {
                        controller.doneTask(value, index);
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
      },
    );
  }
}
