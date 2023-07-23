import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_todo_list/app/modules/home/binding.dart';
import 'package:get_todo_list/app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/services/storage/services.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StroageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      title: 'Todo List using GetX',
      home: HomePage(),
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

