import 'package:flutter_application_17/models/tasks.dart';
import 'package:flutter_application_17/services/task_services.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    isLoading(true);

    try {
      var tasksTemp = await TaskService.fetchTasks();
      if (tasksTemp != null) {
        tasks(tasksTemp);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchTasksForProject(String projectId) async {
    isLoading(true);

    try {
      var tasksTemp = await TaskService.fetchTasksForProject(projectId);
      if (tasksTemp != null) {
        tasks(tasksTemp);
      }
    } finally {
      isLoading(false);
    }
  }
}
