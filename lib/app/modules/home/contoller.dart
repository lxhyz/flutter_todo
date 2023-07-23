
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/data/services/storage/repository.dart';

class HomeController extends GetxController{
  TaskPepository taskPepository;
  HomeController({required this.taskPepository});

  final formKey= GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final tabIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskPepository.readTasks());
    // ever 方法是 GetxController 类提供的一个方法，用于监听任何一个 Rx 类型的变量是否发生了变化，并且可以在变化发生后执行一些逻辑。
    ever(tasks, (callback) => taskPepository.writeTasks(tasks));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTabIndex(int index){
    if(index == 1) {
      getTotalTask();
      getTotalDoneTask();
    }
    tabIndex.value = index;
  }

  void changeChipIndex(int index){
    chipIndex.value = index;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  }

  void changeTask(Task? select){
    task.value = select;
  }

  updateTask(Task task,String title) {
    var todos = task.todos ?? [];
    if(container(todos,title)){
      return false;
    } 
    var todo = {"title":title,"done":false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    var oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool container(List tdos, String title) {
    return tasks.any((element) => element.title == title);
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    } else {
      tasks.add(task);
      tasks.refresh();
      return true;
    }
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for(var i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if(status == true){
        doneTodos.add(select[i]);
      } else {
        doingTodos.add(select[i]);
      }
    }
  }

  bool addTodo(String value) {
    var todo = {"title":value,"done":false};
    if(doingTodos.any((element) => mapEquals<String,dynamic>(todo, element))){
      return false;
    } 
    var doneTodo = {"title":value,"done":true};
    if(doneTodos.any((element) => mapEquals<String,dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String,dynamic>>[];
    newTodos.addAll([...doingTodos,...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(newTask);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {"title":title,"done":false};
    int index = doingTodos.indexWhere((element) => mapEquals<String,dynamic>(element, doingTodo));
    doingTodos.removeAt(index);
    var doneTodo = {"title":title,"done":true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
    print(index);
  }

  deleteDoneTodo(String title) {
    var deleteTodo = {"title":title,"done":true};
    int deleteIndex = doneTodos.indexWhere((element) => mapEquals<String,dynamic>(element, deleteTodo));
    doneTodos.removeAt(deleteIndex);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for(var i = 0; i < task.todos!.length; i++){
      if(task.todos![i]['done']){
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask() {
    var res = 0;
    for(var i = 0; i < tasks.length; i++){
      if(tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for(int i = 0; i < tasks.length; i++) {
      if(tasks[i].todos != null) {
        for(int t = 0; t < tasks[i].todos!.length; t++) {
          if(tasks[i].todos![t]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}