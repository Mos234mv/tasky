// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:todoprof/core/components/task_item_widget.dart';
import 'package:todoprof/models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
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
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage ?? "No Data",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontSize: 24),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),

            sliver: SliverList.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TaskItemWidget(
                    model: tasks[index],
                    onChanged: (bool? value) {
                      ontap(value, index);
                    },
                    onDelete: (int id) {
                      onDelete(id);
                    },
                    onedit: () {
                      onedit();
                    },
                  ),
                );
              },
            ),
          );
  }
}
