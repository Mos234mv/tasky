import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/core/components/task_list_widget.dart';

class HighPirorityScreen extends StatelessWidget {
  const HighPirorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (context) => TasksController()..init(),
      builder: (context, child) {
        final controller = context.read<TasksController>();
        return Scaffold(
          appBar: AppBar(title: Text("High Pirority Tasks")),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<TasksController>(
              builder:
                  (BuildContext context, TasksController value, Widget? child) {
                    return TaskListWidget(
                      tasks: value.highPirority,
                      ontap: (bool? value, int? index) {
                        controller.doneHighPirorityTask(value, index);
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
      },
    );
  }
}
