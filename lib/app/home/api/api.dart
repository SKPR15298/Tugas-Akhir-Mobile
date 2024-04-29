// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../environment/environment.dart';

class NoInduk {
  Future<void> getNoInduk(String noinduk) async {
    String url = '${AppConfig.baseUrl}/api/v1/user/no-induk';

    Map<String, dynamic> requestBody = {
      'no_induk': noinduk,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        String uuid = json.decode(response.body)['data']['uuid'];
        String roleUuid = json.decode(response.body)['data']['role_uuid'];

        await saveuuid(uuid);

        if (roleUuid == "6c96048a-324b-4ea0-a10e-ae8c9da32de8") {
          print("Masuk sebagai Murid");
          Get.offAllNamed("/siswa");
        } else {
          print("Masuk sebagai Wali Kelas");
          Get.offAllNamed("/guru");
        }
      }
    } catch (e) {
      "Error: $e";
    }
  }

  Future<void> saveuuid(String uuid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', uuid);
  }
}
