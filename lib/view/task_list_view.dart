import 'package:flutter/material.dart';
import 'package:flutter_application_17/controllers/task_controllers.dart';
import 'package:get/get.dart';

class TaskListView extends StatelessWidget {
  final String projectId;
  final String projectName; // Add projectName parameter

  TaskListView({required this.projectId, required this.projectName});

  @override
  Widget build(BuildContext context) {
    final TaskController _taskController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          projectName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() => _taskController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _taskController.tasks.length,
              itemBuilder: (context, index) {
                final task = _taskController.tasks[index];
                if (task.projId == projectId) {
                  return GestureDetector(
                    onTap: () {
                      // Handle task item tap here if needed
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  task.taskName,
                                  style: TextStyle(
                                    color: Color.fromRGBO(76, 85, 102, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18, // Adjust the font size here
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  children: [
                                    CircularProgressIndicator(
                                      value:
                                          _getStatusPercentage(task.statusId) /
                                              100,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getStatusColor(task.statusId),
                                      ),
                                      strokeWidth: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        '${_getStatusPercentage(task.statusId)}%',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              10, // Adjust the font size here
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )),
    );
  }

  Color _getStatusColor(int statusId) {
    // Define color for different status IDs (You can customize these colors as per your requirement)
    switch (statusId) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  int _getStatusPercentage(int statusId) {
    // Assuming statusId represents the progress percentage (0 to 100)
    return statusId;
  }
}
