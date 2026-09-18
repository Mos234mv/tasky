// ignore_for_file: strict_top_level_inference, unused_field, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();
  FileStorageManager._();

  factory FileStorageManager() => _instance;
  late final Directory _appDocumentDirectory;
  late final File _tasksFile;

  init() async {
    _appDocumentDirectory = await getApplicationCacheDirectory();

    _tasksFile = File('${_appDocumentDirectory.path}/tasks.json');
  }

  saveTask(List<dynamic> list) async {
    final listJson = jsonEncode(list);
    await _tasksFile.writeAsString(listJson);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];
    final taskJson = await _tasksFile.readAsString();
    return jsonDecode(taskJson) as List<dynamic>;
  }
}
