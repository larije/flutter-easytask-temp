import 'dart:convert';
import 'package:flutter_application_17/models/tasks.dart'; // Import the Task model
import 'package:http/http.dart' as http;

class TaskService {
  static var client = http.Client();

  static Future<List<Task>?> fetchTasks() async {
    try {
      var response = await client.get(
        Uri.parse('https://davaodelnorte.ph/EASYTASK/DATA/api/projectTasks'),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        List<Task> tasks =
            (jsonData as List).map((e) => Task.fromJson(e)).toList();

        return tasks;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error while fetching tasks: $e');
      return null;
    }
  }

  static Future<List<Task>?> fetchTasksForProject(String projId) async {
    try {
      var response = await client.get(
        Uri.parse(
            'https://davaodelnorte.ph/EASYTASK/DATA/api/projectTasks?projId=$projId'),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        List<Task> tasks =
            (jsonData as List).map((e) => Task.fromJson(e)).toList();

        return tasks;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error while fetching tasks for project: $e');
      return null;
    }
  }
}
