import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  // Use Mac localhost for iPhone simulator:
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> analyzeSkin(String imagePath) async {
    var uri = Uri.parse("$baseUrl/analyze");

    var request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromPath("file", imagePath));

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception(
          "Failed to analyze image. Status code: ${res.statusCode}");
    }
  }
}
