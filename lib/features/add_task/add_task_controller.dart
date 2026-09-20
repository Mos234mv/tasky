import 'package:flutter/material.dart';
import 'package:todoprof/core/services/file_storage_manager.dart';
import 'package:todoprof/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskdescriptioncontroller =
      TextEditingController();
  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      List<TaskModel> listtasks = HiveStorageManager().loadTasks();
      TaskModel model = TaskModel(
        id: listtasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskdescriptioncontroller.text,
        isHighPriority: isHighPriority,
      );

      listtasks.add(model);
      await HiveStorageManager().saveTask(listtasks);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
