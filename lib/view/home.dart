import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_17/controllers/project_controllers.dart';
import 'package:flutter_application_17/controllers/task_controllers.dart';
import 'package:flutter_application_17/view/task_list_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ProjectController _newsController = Get.put(ProjectController());
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildCountContainer(
                        title: 'Projects',
                        count: _newsController.projects.length,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildCountContainer(
                        title: 'Tasks',
                        count: _taskController.tasks.length,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Obx(() => _newsController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _newsController.projects.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final project = _newsController.projects[index];
                      return GestureDetector(
                        onTap: () {
                          String selectedProjectId = project.projId;
                          String selectedProjectName = project.projTitle;
                          _taskController
                              .fetchTasksForProject(selectedProjectId);
                          Get.to(() => TaskListView(
                                projectId: selectedProjectId,
                                projectName: selectedProjectName,
                              ));
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.projTitle,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(76, 85, 102, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Owner: ${project.projOwner}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              _buildCircularProgressBar(project.statusId
                                  .toDouble()), // Convert to double
                            ],
                          ),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }

  Widget _buildCountContainer(
      {required String title, required int count, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressBar(double statusId) {
    return Container(
      width: 50,
      height: 50,
      child: CustomPaint(
        foregroundPainter: CircleProgressBarPainter(statusId),
        child: Center(
          child: Text(
            '${statusId.toInt()}%',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double progress;

  CircleProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint completePaint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Paint incompletePaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 2.5;

    canvas.drawCircle(center, radius, incompletePaint);
    double arcAngle = 2 * pi * (progress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, completePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
