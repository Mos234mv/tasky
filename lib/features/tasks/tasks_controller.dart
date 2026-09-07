import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;
  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPirority = [];
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0;
  init() {
    loadTask();
  }

  void _calculate() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
    notifyListeners();
  }

  void loadTask() {
    isLoading = true;

    final finalTask = PrefrenceManager().getString(StorageKey.modelTasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      _calculate();
      _loadData();
    }
    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;
    _loadData();
    _calculate();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString('tasks', jsonEncode(updatedTask));
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    _loadData();
    _calculate();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completeTasks = tasks.where((e) => e.isDone).toList();
    highPirority = tasks
        .where((element) => element.isHighPriority)
        .toList()
        .reversed
        .toList();
  }
}
