import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

import 'package:todoprof/core/Theme/theme_controller.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/services/file_storage_manager.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_svg_picture.dart';

import 'package:todoprof/features/profile/user_details.dart';
import 'package:todoprof/features/tasks/tasks_controller.dart';
import 'package:todoprof/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationquote;
  bool isLoading = true;
  String? userImagePath;

  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      username = PrefrenceManager().getString(StorageKey.userName) ?? '';
      motivationquote =
          PrefrenceManager().getString(StorageKey.motivationQuote) ??
          "One task at a time. One step closer.";
      isLoading = false;
    });
    userImagePath = PrefrenceManager().getString(StorageKey.userImage);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppSizes.ph8),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: AppSizes.ph16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: userImagePath == null
                                ? AssetImage(
                                    'assets/Images/Leading element.png',
                                  )
                                : FileImage(File(userImagePath!)),
                            radius: AppSizes.r60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () async {
                              _showImaeSourceDialog(context, (XFile file) {
                                _saveImae(file);
                                setState(() {
                                  userImagePath = file.path;
                                });
                              });
                            },
                            child: Container(
                              height: AppSizes.h46,
                              width: AppSizes.w46,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r100,
                                ),
                              ),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.ph6),

                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationquote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.ph24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSizes.ph24),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            motivationQuote: motivationquote,
                          );
                        },
                      ),
                    );
                    if (result != null && result == true) {
                      loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("User Details"),

                  leading: CustomSvgPicture(
                    path: 'assets/Images/personIcon.svg',
                  ),

                  trailing: CustomSvgPicture(
                    path: 'assets/Images/arrowprofile.svg',
                  ),
                ),

                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),

                  leading: CustomSvgPicture(path: 'assets/Images/Darkmode.svg'),

                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (value) async {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),

                Divider(),
                ListTile(
                  onTap: () async {
                    PrefrenceManager().remove(StorageKey.userName);
                    PrefrenceManager().remove(StorageKey.motivationQuote);
                    await HiveStorageManager().clear();
                    context.read<TasksController>().clearTasks();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Welcome();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("Log Out"),

                  leading: CustomSvgPicture(path: 'assets/Images/Logout.svg'),

                  trailing: CustomSvgPicture(
                    path: 'assets/Images/arrowprofile.svg',
                  ),
                ),
              ],
            ),
          );
  }

  void _showImaeSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Choose Imae Source",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw8),
                  Text(
                    "Camera",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: AppSizes.pw8),
                  Text(
                    "Studio",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImae(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newfile = await File(file.path).copy('${appDir.path}/${file.name} ');
    PrefrenceManager().setString(StorageKey.userImage, newfile.path);
  }
}
