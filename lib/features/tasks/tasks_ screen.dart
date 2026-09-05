import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/core/components/task_list_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<TaskModel> todoTasks = [];
  bool isChecked = false;
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

    final finalTask = PrefrenceManager().getString(StorageKey.modelTasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => !element.isDone)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    final finalTask = PrefrenceManager().getString(StorageKey.modelTasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((task) => task.id == id);

      if (id == null) return;
      setState(() {
        todoTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PrefrenceManager().setString(
        StorageKey.modelTasks,
        jsonEncode(updatedTask),
      );
    }
  }

  Widget build(BuildContext context) {
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
            child: TaskListWidget(
              tasks: todoTasks,
              ontap: (bool? val, int? index) async {
                setState(() {
                  todoTasks[index!].isDone = val ?? false;
                });

                final allData = PrefrenceManager().getString(
                  StorageKey.modelTasks,
                );
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTasks[index!].id,
                  );
                  allDataList[newIndex] = todoTasks[index!];

                  PrefrenceManager().setString(
                    StorageKey.modelTasks,
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
