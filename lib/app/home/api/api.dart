// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../environment/environment.dart';

class NoInduk {
  Future<void> getNoInduk(String noinduk) async {
    String url = '${AppConfig.baseUrl}api/v1/user/no-induk';

    Map<String, dynamic> requestBody = {
      'no_induk': noinduk,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        String uuid = json.decode(response.body)['data']['uuid'];
        String roleUuid = json.decode(response.body)['data']['role_uuid'];

        print("uuid= $uuid");
        print("role_uuid= $roleUuid");
      }
    } catch (e) {
      "Error: $e";
    }
  }
}
