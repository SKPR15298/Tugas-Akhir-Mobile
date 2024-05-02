// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../environment/environment.dart';

class AbsenFetch {
  static Future<Map<String, dynamic>?> fetchJadwal() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/api/v1/absen/jadwal'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
