import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/constants.dart';
import 'package:todoprof/core/services/file_storage_manager.dart';
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

  void loadTask() async {
    isLoading = true;

    tasks = HiveStorageManager().loadTasks();

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;
    _loadData();
    _calculate();

    HiveStorageManager().saveTask(tasks);

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    _loadData();
    _calculate();

    HiveStorageManager().saveTask(tasks);

    notifyListeners();
  }

  void _loadData() async {
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completeTasks = tasks.where((e) => e.isDone).toList();
    highPirority = tasks
        .where((element) => element.isHighPriority)
        .toList()
        .reversed
        .toList();
  }

  void clearTasks() {
    loadTask();
  }
}
