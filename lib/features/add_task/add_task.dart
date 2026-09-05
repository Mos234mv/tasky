import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/storage_key.dart';

import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_text_form_field.dart';
import 'package:todoprof/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskdescriptioncontroller =
      TextEditingController();
  bool isHighPriority = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          controller: taskNameController,
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
                          controller: taskdescriptioncontroller,
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
                              style: Theme.of(context).textTheme.titleMedium,
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
                        StorageKey.modelTasks,
                      );

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
                      final taskEncode = jsonEncode(listtasks);
                      await PrefrenceManager().setString(
                        StorageKey.modelTasks,
                        taskEncode,
                      );

                      Navigator.of(context).pop(true);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Task"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
