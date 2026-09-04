import 'package:flutter/material.dart';

import 'package:todoprof/core/widgets/task_item_widget.dart';
import 'package:todoprof/models/task_model.dart';

// ignore: must_be_immutable
class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.ontap,
    this.emptyMessage,
    required this.onDelete,
    required this.onedit,
  });
  List<TaskModel> tasks;
  final Function(bool?, int?) ontap;
  final Function(int?) onDelete;
  final Function onedit;

  final String? emptyMessage;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? "No Data",
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontSize: 24),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 60),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    ontap(value, index);
                  },
                  onDelete: (int? id) {
                    onDelete(id);
                  },
                  onedit: () {
                    onedit();
                  },
                ),
              );
            },
          );
  }
}
