import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/details/widgets/doing_list.dart';
import 'package:get_todo_list/app/modules/details/widgets/done_list.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatelessWidget {
  final  homeController = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    // var color = HexColor.fromHex(task.color);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        titleTextStyle: TextStyle(
          color: Colors.black
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            homeController.updateTodos();
            homeController.changeTask(null);
            homeController.editController.clear();
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Form(
        key: homeController.formKey,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.0.wp),
          child: ListView(
            children: [
              Row(
                children: [
                  Icon(IconData(task!.icon,fontFamily: "MaterialIcons")),
                  SizedBox(width: 3.0.wp,),
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.0.wp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0.wp,),
              Obx((){
                var totalTodos = homeController.doingTodos.length + homeController.doneTodos.length;
                return Padding(
                  padding:  EdgeInsets.only(
                    left: 3.0.wp
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${totalTodos} Tasks",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.7),
                          fontSize: 2.0.wp
                        ),
                      ),
                      SizedBox(width: 3.0.wp,),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeController.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.pink.withOpacity(.5),
                              Colors.orange,
                            ]
                          ),
                          unselectedGradientColor:  LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.grey.withOpacity(.5),
                              Colors.black.withOpacity(.3),
                            ]
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.wp,vertical: 2.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.black,
                    ),
                    suffixIcon:IconButton(
                      splashColor: Colors.transparent,
                      onPressed: (){
                        if(homeController.formKey.currentState!.validate()) {
                          var success = homeController.addTodo(homeController.editController.text);
                          if(success) {
                            EasyLoading.showSuccess("Todo item add sucess");
                          } else {
                            EasyLoading.showError("Todo item already exist");
                          }
                          homeController.editController.clear();
                        }
                      }, 
                      icon: Icon(
                        Icons.done,
                        color: Colors.black,
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black)
                    )
                  ),
                  validator: (value){
                    if(value == null || value.trim().isEmpty ){
                      return "Please enter you todo item";
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}