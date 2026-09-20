// ignore_for_file: strict_top_level_inference, unused_field, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoprof/core/constants/constants.dart';
import 'package:todoprof/models/task_model.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();
  HiveStorageManager._();

  factory HiveStorageManager() => _instance;

  late Box<TaskModel> _taskBox;
  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(Constants.taskNameCollection);
  }

  saveTask(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  Future<void> clear() async {
    await _taskBox.clear();
  }
}
