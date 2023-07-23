import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty 
      ? Column(
        children: [
          Image.asset(
            "assets/images/no_todos.png",
            fit: BoxFit.contain,
            width: 65.0.wp,
          ),
          Text(
            "Add Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 3.0.wp
            ),
          )
        ],
      ) :
      ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          ...homeController.doingTodos.map((element) {
            return Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 3.0.wp,
                vertical: 1.0.wp
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith((states) => Colors.black.withOpacity(.5)),
                      value: element['done'], 
                      onChanged: (Value){
                        homeController.doneTodo(element['title']);
                      }
                    ),
                  ),
                  SizedBox(width: 2.0.wp,),
                  Text(
                    element['title'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 2.5.wp,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            );
          }).toList(),
          if(homeController.doingTodos.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
            child: Divider(thickness: 2,),
          )
        ],
      ); 
    });
  }
}