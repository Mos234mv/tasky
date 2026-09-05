// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/Theme/theme_controller.dart';
import 'package:todoprof/core/constants/storage_key.dart';
import 'package:todoprof/core/enums/task_item_actions_enum.dart';
import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_ceckbox.dart';
import 'package:todoprof/core/widgets/custom_text_form_field.dart';
import 'package:todoprof/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onedit,
  });
  final TaskModel model;
  final Function(bool? value) onChanged;
  final Function(int) onDelete;
  final Function onedit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.themeNotifier.value == ThemeMode.light
              ? Color(0xFFD1DAD6)
              : Colors.transparent,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCeckbox(
            value: model.isDone,
            onChanged: (value) {
              onChanged(value);
            },
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,

                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0xFFA0A0A0) : Color(0xFFC6C6C6))
                  : (model.isDone ? Color(0xFF6A6A6A) : Color(0xFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                  break;
                case TaskItemActionsEnum.edit:
                  final result = await _showBottomSeet(context, model);
                  if (result == true) {
                    onedit();
                  }

                  break;
                case TaskItemActionsEnum.delete:
                  _show_Dialog(context);

                  break;
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showBottomSeet(BuildContext context, TaskModel model) {
    final TextEditingController namecontroller = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController descontroller = TextEditingController(
      text: model.taskDescription,
    );
    bool isHighPriority = model.isHighPriority;
    final GlobalKey<FormState> _key = GlobalKey();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CustomTextFormField(
                              title: "Task Name",
                              controller: namecontroller,
                              hintText: 'Finish UI design for login screen',

                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Task Name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            CustomTextFormField(
                              title: "Task Description",
                              controller: descontroller,
                              hintText:
                                  'Finish onboarding UI and hand off to devs by Thursday',
                              maxlines: 5,
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),

                                Switch(
                                  value: isHighPriority,
                                  onChanged: (val) {
                                    setState(() {
                                      isHighPriority = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          final taskJason = PrefrenceManager().getString(
                            "tasks",
                          );

                          List<dynamic> listTasks = [];
                          if (taskJason != null) {
                            listTasks = jsonDecode(taskJason);
                          }
                          TaskModel newmodel = TaskModel(
                            id: model.id,
                            taskName: namecontroller.text,
                            taskDescription: descontroller.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );
                          final item = listTasks.firstWhere(
                            (e) => e[StorageKey.id] == model.id,
                          );
                          final index = listTasks.indexOf(item);
                          listTasks[index] = newmodel;

                          final taskEncode = jsonEncode(listTasks);
                          await PrefrenceManager().setString(
                            "tasks",
                            taskEncode,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Edit Task"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _show_Dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are You Sure to delete this task '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
