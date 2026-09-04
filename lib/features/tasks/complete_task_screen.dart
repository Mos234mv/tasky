import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/core/components/task_list_widget.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  List<TaskModel> completeTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PrefrenceManager().getString('tasks');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        completeTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == true)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    final finalTask = PrefrenceManager().getString('tasks');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((task) => task.id == id);

      if (id == null) return;
      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PrefrenceManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TaskListWidget(
              tasks: completeTasks,
              ontap: (bool? val, int? index) async {
                setState(() {
                  completeTasks[index!].isDone = val ?? false;
                });

                final allData = PrefrenceManager().getString("tasks");

                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTasks[index!].id,
                  );
                  allDataList[newIndex] = completeTasks[index!];
                  await PrefrenceManager().setString(
                    "tasks",
                    jsonEncode(allDataList),
                  );

                  _loadTask();
                }
              },
              emptyMessage: "No Tasks Found",
              onDelete: (int? id) {
                _deleteTask(id);
              },
              onedit: () {
                _loadTask();
              },
            ),
          ),
        ),
      ],
    );
  }
}
