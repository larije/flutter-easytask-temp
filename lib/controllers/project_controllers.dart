import 'package:flutter_application_17/models/project.dart';
import 'package:flutter_application_17/services/project_services.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  var projects = <Project>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  void fetchProjects() async {
    isLoading(true);

    try {
      isLoading(true);
      var projectsTemp = await WebService.fetchProjects();
      if (projectsTemp != null) {
        projects(projectsTemp);
      }
    } finally {
      isLoading(false);
    }
  }
}
