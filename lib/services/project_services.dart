import 'dart:convert';
import 'package:flutter_application_17/models/project.dart';
import 'package:http/http.dart' as http;

class WebService {
  static var client = http.Client();

  static Future<List<Project>?> fetchProjects() async {
    try {
      var response = await client.get(
        Uri.parse('https://davaodelnorte.ph/EASYTASK/DATA/api/projects'),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        List<Project> projects =
            (jsonData as List).map((e) => Project.fromJson(e)).toList();

        return projects;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error while fetching news: $e');
      return null;
    }
  }
}
