// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../environment/environment.dart';

class DataFetch {
  static Future<String?> getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString('uuid');
    return uuid;
  }

  static Future<Map<String, dynamic>?> fetchUser() async {
    try {
      String? uuid = await getUUID();

      if (uuid != null) {
        final response =
            await http.get(Uri.parse('${AppConfig.baseUrl}/api/v1/user/$uuid'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          print("get: $responseData");
        } else {
          print("Error: ${response.statusCode}");
        }
      } else {
        print("UUID not found in SharedPreferences");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
