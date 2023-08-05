import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_application_17/view/home.dart';
import 'package:flutter_application_17/controllers/project_controllers.dart';
import 'package:flutter_application_17/controllers/task_controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeView(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => ProjectController());
        Get.lazyPut(() => TaskController());
      }),
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
    );
  }
}
