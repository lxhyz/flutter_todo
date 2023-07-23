import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/values/colors.dart';
import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/home/widgets/add_card.dart';
import 'package:get_todo_list/app/modules/home/widgets/add_dialog.dart';
import 'package:get_todo_list/app/modules/home/widgets/task_card.dart';
import 'package:get_todo_list/app/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() {
            return IndexedStack(
              index: controller.tabIndex.value,
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0.wp),
                      child: Text(
                        "My List",
                        style: TextStyle(
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Obx((){
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...controller.tasks.map((e){
                            return LongPressDraggable(
                              data: e,
                              child: TaskCard(task: e,), 
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(task: e,),
                              ),
                              onDragStarted: () => controller.changeDeleting(true),
                              onDraggableCanceled: (Velocity,Offset) => controller.changeDeleting(false),
                              onDragEnd: (_)=> controller.changeDeleting(false),
                            );
                          }).toList(),
                          AddCard(),
                        ],
                      );
                    })
                  ],
                ),
                ReportView()
              ],
            );
          }),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_,__,___){
          return Obx(() {
            return FloatingActionButton(
              onPressed: (){
                if(controller.tasks.isNotEmpty){
                  Get.to(
                    () => AddDialog(),
                    transition: Transition.downToUp,
                  );
                } else  {
                  EasyLoading.showInfo("Please create you task type");
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
              backgroundColor: controller.deleting.value ? Colors.red : Colors.blue,
            );
          });
        },
        onAccept: (Task task){
          controller.deleteTask(task);
          EasyLoading.showSuccess("删除成功");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx((){
        return BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.data_usage),label: "详情"),
          ],
          onTap:(int index){
            controller.changeTabIndex(index);
          }
        );
      }),
    );
  }
}