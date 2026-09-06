import 'dart:convert';

import 'package:flutter/material.dart';
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

  calculate() {
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
      calculate();
      todoTasks = tasks.where((e) => !e.isDone).toList();
      completeTasks = tasks.where((e) => e.isDone).toList();
      highPirority = tasks
          .where((element) => element.isHighPriority)
          .toList()
          .reversed
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;
    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(tasks),
    );
    loadTask();
    notifyListeners();
  }

  deleteTask(int? id) async {
    tasks.removeWhere((task) => task.id == id);

    if (id == null) return;

    todoTasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    highPirority.removeWhere((task) => task.id == id);

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;
    final int newIndex = tasks.indexWhere(
      (e) => e.id == completeTasks[index].id,
    );
    tasks[newIndex] = completeTasks[index];
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(tasks),
    );
    loadTask();
    notifyListeners();
  }

  void doneHighPirorityTask(bool? value, int? index) async {
    if (index == null) return;
    highPirority[index].isDone = value ?? false;
    final int newIndex = tasks.indexWhere(
      (e) => e.id == highPirority[index].id,
    );
    tasks[newIndex] = highPirority[index];
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(tasks),
    );
    loadTask();
    notifyListeners();
  }
}
