import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/core/components/task_list_widget.dart';

class HighPirorityScreen extends StatefulWidget {
  const HighPirorityScreen({super.key});

  @override
  State<HighPirorityScreen> createState() => _HighPirorityScreen();
}

class _HighPirorityScreen extends State<HighPirorityScreen> {
  List<TaskModel> highPirority = [];
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
        highPirority = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isHighPriority)
            .toList()
            .reversed
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
        highPirority.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PrefrenceManager().setString(
        StorageKey.modelTasks,
        jsonEncode(updatedTask),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Pirority Tasks")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TaskListWidget(
          tasks: highPirority,
          ontap: (bool? val, int? index) async {
            setState(() {
              highPirority[index!].isDone = val ?? false;
            });

            final allData = PrefrenceManager().getString(StorageKey.modelTasks);
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
              final int newIndex = allDataList.indexWhere(
                (e) => e.id == highPirority[index!].id,
              );
              allDataList[newIndex] = highPirority[index!];

              await PrefrenceManager().setString(
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
    );
  }
}
