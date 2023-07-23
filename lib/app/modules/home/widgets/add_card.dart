import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/data/models/task.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squredWidth = Get.width - 12.0.wp;
    return Container(
      width: squredWidth / 2,
      height: squredWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 3.0.wp),
            radius: 5,
            title: 'Task Type',
            onWillPop: (){
              homeController.changeChipIndex(0);
              homeController.editController.clear();
              return Future(() => true);
            },
            content: Form(
              key: homeController.formKey,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeController.editController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title'
                      ),
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'Please enter you task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 0.0.wp),
                    child: Wrap(
                      spacing: 3.0.wp,
                      children: icons.map((e) => Obx(
                        (){
                          final index = icons.indexOf(e);
                          return ChoiceChip(
                            label: e, 
                            selected: homeController.chipIndex == index,
                            backgroundColor: Colors.white,
                            onSelected: (bool selected){
                              // homeController.chipIndex.value = selected ? index : 0;
                              homeController.chipIndex.value = index;
                            },
                          );
                        }
                      )).toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      minimumSize: Size(150, 40)
                    ),
                    onPressed: (){
                      if(homeController.formKey.currentState!.validate()){
                        int icon = icons[homeController.chipIndex.value].icon!.codePoint;
                        String color = icons[homeController.chipIndex.value].color!.toString();
                        var task = Task(
                          title: homeController.editController.text,
                          icon: icon,
                          color: color
                        );
                        Get.back();
                        homeController.addTask(task) ? EasyLoading.showSuccess("Create success") : EasyLoading.showError("Create fail");
                        print(homeController.editController.text);
                        print("${icons[homeController.chipIndex.toInt()]}");
                      }
                    }, 
                    child: Text("confirm")
                  ),
                ],
              )
            ),
          );
        },
        child: DottedBorder(
          color: Colors.grey.withOpacity(.4),
          dashPattern: [8,4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 20.0.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}