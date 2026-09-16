import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';

class HomeController with ChangeNotifier {
  String? username;

  bool isChecked = false;
  bool isLoading = false;

  String? userImagePath;

  void init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PrefrenceManager().getString(StorageKey.userName);
    userImagePath = PrefrenceManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
