import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';

class HomeController with ChangeNotifier {
  String? username;
  List<TaskModel> tasks = [];
  bool isChecked = false;
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0;
  String? userImagePath;

  void init() {
    loadusername();
    loadTask();
  }

  void loadTask() async {
    isLoading = true;

    final finalTask = PrefrenceManager().getString(StorageKey.modelTasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      calculate();

      isLoading = false;
      notifyListeners();
    }
  }

  void loadusername() async {
    username = PrefrenceManager().getString(StorageKey.userName);
    userImagePath = PrefrenceManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  calculate() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
    notifyListeners();
  }

  doneTask(bool? val, int? index) async {
    tasks[index!].isDone = val ?? false;
    calculate();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);

    calculate();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString(
      StorageKey.modelTasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
