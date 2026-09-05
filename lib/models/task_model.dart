import 'package:todoprof/core/constants/storage_key.dart';

class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone = false;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
    required this.id,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[StorageKey.id],
      taskName: json[StorageKey.taskName],
      taskDescription: json[StorageKey.taskDescription],
      isHighPriority: json[StorageKey.isHighPriority],
      isDone: json[StorageKey.isDone] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      StorageKey.id: id,
      StorageKey.taskName: taskName,
      StorageKey.taskDescription: taskDescription,
      StorageKey.isHighPriority: isHighPriority,
      StorageKey.isDone: isDone,
    };
  }
}
