import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoprof/core/widgets/custom_text_form_field.dart';
import 'package:todoprof/features/add_task/add_task_controller.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: controller.key,
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
                              controller: controller.taskNameController,
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
                              controller: controller.taskdescriptioncontroller,
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

                                Consumer<AddTaskController>(
                                  builder:
                                      (
                                        BuildContext context,
                                        val,
                                        Widget? child,
                                      ) {
                                        return Switch(
                                          value: val.isHighPriority,
                                          onChanged: (value) {
                                            controller.toggle(value);
                                          },
                                        );
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
                        context.read<AddTaskController>().addTask(context);
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
      },
    );
  }
}
