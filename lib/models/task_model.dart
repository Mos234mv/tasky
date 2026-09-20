import 'package:hive_ce/hive.dart';
import 'package:todoprof/core/constants/storage_key.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String taskName;
  @HiveField(2)
  final String taskDescription;
  @HiveField(3)
  final bool isHighPriority;
  @HiveField(4)
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
