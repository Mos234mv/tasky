// ignore_for_file: strict_top_level_inference, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:todoprof/core/services/prefrence_manager.dart';
import 'package:todoprof/core/widgets/custom_svg_picture.dart';
import 'package:todoprof/models/task_model.dart';
import 'package:todoprof/features/add_task/add_task.dart';
import 'package:todoprof/core/widgets/achieved%20tasks.dart';
import 'package:todoprof/core/widgets/high_pirority.dart';
import 'package:todoprof/core/widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isChecked = false;
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0;
  String? userImagePath;

  @override
  void initState() {
    super.initState();
    _loadusername();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PrefrenceManager().getString('tasks');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculate();
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  void _loadusername() async {
    setState(() {
      username = PrefrenceManager().getString('username');
      userImagePath = PrefrenceManager().getString('userImage');
    });
  }

  _calculate() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  _doneTask(bool? val, int? index) async {
    setState(() {
      tasks[index!].isDone = val ?? false;
      _calculate();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((task) => task.id == id);

      _calculate();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PrefrenceManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 168,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTask();
                },
              ),
            );
            if (result != null && result == true) {
              _loadTask();
            }
          },

          label: Text('Add New Task'),
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/Images/Leading element.png')
                            : FileImage(File(userImagePath!)),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening , $username",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "One task at a time.One step closer.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Yuhuu ,Your work Is ',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done !',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(width: 8),
                      CustomSvgPicture(
                        path:
                            'assets/Images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                        withColor: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTaskWidget(
                    totalDoneTask: totalDoneTask,
                    totalTask: totalTask,
                    percentage: percentage,
                  ),
                  SizedBox(height: 8),
                  HighPirorityWidget(
                    tasks: tasks.where((e) => e.isHighPriority).toList(),
                    ontap: (bool? val, int? index) {
                      _doneTask(val, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),

            SliverTaskListWidget(
              tasks: tasks,
              ontap: (bool? val, int? index) {
                _doneTask(val, index);
              },
              onDelete: (int? id) {
                _deleteTask(id);
              },
              onedit: () {
                _loadTask();
              },
            ),
          ],
        ),
      ),
    );
  }
}
