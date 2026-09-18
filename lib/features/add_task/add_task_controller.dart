import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/file_storage_manager.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskdescriptioncontroller =
      TextEditingController();
  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskJason = PrefrenceManager().getString(StorageKey.modelTasks);

      List<dynamic> listtasks = [];
      if (taskJason != null) {
        listtasks = jsonDecode(taskJason);
      }
      TaskModel model = TaskModel(
        id: listtasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskdescriptioncontroller.text,
        isHighPriority: isHighPriority,
      );

      listtasks.add(model.toJson());
      await FileStorageManager().saveTask(listtasks);
      final taskEncode = jsonEncode(listtasks);
      await PrefrenceManager().setString(StorageKey.modelTasks, taskEncode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
