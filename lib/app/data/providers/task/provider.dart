import 'dart:convert';

import 'package:get_todo_list/app/core/utils/keys.dart';
import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class TaskProviders {
  final StroageService _stroage = Get.find<StroageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_stroage.read(taskkey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> task){
    _stroage.write(taskkey, jsonEncode(task));
  } 
}