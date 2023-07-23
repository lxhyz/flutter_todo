import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';


class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.all(2.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton( 
                    onPressed: (){
                      Get.back();
                      homeController.editController.clear();
                      homeController.changeTask(null);
                    }, 
                    icon: Icon(Icons.close)
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    onPressed: (){
                      if(homeController.formKey.currentState!.validate()){
                        if(homeController.task.value == null){
                          EasyLoading.showError("Please select task type");
                        } else {
                          var success = homeController.updateTask(
                            homeController.task.value!,
                            homeController.editController.text,
                          );
                          if(success) {
                            EasyLoading.showSuccess("Todo item add success");
                            Get.back();
                            homeController.changeTask(null);
                            homeController.editController.clear();
                          } else {
                            EasyLoading.showError("Todo item add fail");
                          }
                        }
                      }
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.blue.withOpacity(.8),
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Text(
                "NEW Task",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:3.0.wp),
              child: TextFormField(
                controller: homeController.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)
                  )
                ),
                autofocus: true,
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Please enter you todo item";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 3.0.wp,
                right: 3.0.wp,
                top: 3.0.wp,
                bottom: 1.5.wp
              ),
              child: Text(
                "Add to",
                style: TextStyle(
                  fontSize: 3.0.wp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
            ),
            ...homeController.tasks.map((element){
              return InkWell(
                onTap: (){
                  homeController.changeTask(element);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.wp,vertical: 1.5.wp),
                  child: Obx((){
                    return Row(
                    children: [
                      Icon(IconData(element.icon,fontFamily: "MaterialIcons")),
                        SizedBox(width: 2.0.wp,),
                        Expanded(
                          child: Text(
                            "${element.title}",
                            style: TextStyle(
                              fontSize: 2.5.wp,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        if (homeController.task.value == element )Icon(Icons.check,color: Colors.blue,)
                      ],
                    );
                  }),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}