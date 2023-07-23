import 'package:get/get.dart';
import 'package:get_todo_list/app/data/providers/task/provider.dart';
import 'package:get_todo_list/app/data/services/storage/repository.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';

class HomeBinding implements Bindings{
  
  @override
  void dependencies(){
    Get.lazyPut(() => HomeController(
      taskPepository: TaskPepository(
        taskProviders: TaskProviders()
      )
    ));
  }
}