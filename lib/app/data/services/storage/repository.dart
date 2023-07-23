import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/data/providers/task/provider.dart';

class TaskPepository {
  TaskProviders taskProviders;
  TaskPepository({required this.taskProviders});

  List<Task> readTasks() => taskProviders.readTasks();
  void writeTasks(List<Task> tasks) => taskProviders.writeTasks(tasks);
}