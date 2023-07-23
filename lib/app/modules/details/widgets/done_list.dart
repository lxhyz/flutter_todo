import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return homeController.doneTodos.isNotEmpty
      ? 
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.wp,vertical: 2.0.wp),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Complated (${homeController.doneTodos.length})",
              style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontSize: 2.5.wp
              ),
            ),
            ...homeController.doneTodos.map((element){
              return Dismissible(
                key: ObjectKey(element),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => homeController.deleteDoneTodo(element['title']),
                background: Container(
                  color: Colors.red.withOpacity(.8),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete,color: Colors.white,),
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.0.wp),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 3.0.wp,),
                      Text(
                        element['title'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 2.5.wp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.6)
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      )
      :
      Container(
      );
    });
  }
}