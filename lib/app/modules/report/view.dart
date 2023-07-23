import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/core/values/colors.dart';
import 'package:intl/intl.dart';
import 'package:get_todo_list/app/core/utils/extensions.dart';
import 'package:get_todo_list/app/modules/home/contoller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportView extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeCtrl.getTotalDoneTask();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTasks;
          var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 3.0.wp),
                child: Text(
                  "My Report",
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 0.0.wp,horizontal: 3.0.wp),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0.wp,horizontal: 3.0.wp),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.0.wp,vertical: 3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   _buildState(Colors.green,liveTasks,'Live Tasks'), 
                   _buildState(Colors.orange,completedTasks,'Completed'), 
                   _buildState(Colors.blue,createdTasks,'Created'), 
                  ],
                ),
              ),
              SizedBox(height: 2.0.wp,),
              UnconstrainedBox(
                child: SizedBox(
                  width: 50.0.wp,
                  height: 50.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps:createdTasks == 0 ? 1: createdTasks,
                    currentStep:completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey.withOpacity(0.2),
                    padding: 0,
                    width: 100,
                    height: 100,
                    selectedStepSize: 22,
                    roundedCap: (_,__) => true,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${createdTasks == 0 ? 0 : percent} %",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0.sp
                            ),
                          ),
                          SizedBox(height: 2.0.wp,),
                          Text(
                            "Efficience",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                    ),
                  ),
                ),
              )
            ],
          );
        })
      ),
    );
  }

  Row _buildState(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,    
            border: Border.all(
              width: 0.5.wp,
              color: color
            )        
          ),
        ),
        SizedBox(width: 3.0.wp,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp
              ),
            ),
            SizedBox(height: 2.0.wp,),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey
              ),
            )
          ],
        )
      ],
    );
  }
}


