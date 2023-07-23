import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/modules/details/view.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key,required this.task});

  @override
  Widget build(BuildContext context) {
    var squredWidth = Get.width - 12.0.wp;
    return  GestureDetector(
      onTap: (){
        homeController.changeTask(task);
        homeController.changeTodos(task.todos ?? []);
        Get.to(
          () => DetailPage()
        );
      },
      child: Container(
        width: squredWidth /2,
        height: squredWidth /2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white, // 暂时写死 task.color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 7,
              offset: Offset(0, 7)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeController.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep:homeController.isTodosEmpty(task) ?  0 : homeController.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.pink.withOpacity(.6),
                  Colors.orange.withOpacity(.5)
                ]
              ),
              unselectedGradientColor: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp,vertical: 1.0.wp),
              child: Text(
                "${(task.todos == null ? 0 : task.todos!.length)} Task",
                style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}