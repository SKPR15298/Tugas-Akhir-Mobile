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
          return responseData;
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      } else {
        print("UUID not found in SharedPreferences");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchKelas() async {
    try {
      Map<String, dynamic>? userData = await fetchUser();

      if (userData != null && userData.containsKey('data')) {
        Map<String, dynamic> data = userData['data'];

        if (data.containsKey('kelas') && data['kelas'] is Map) {
          String? kelasUuid = data['kelas']['uuid'];

          if (kelasUuid != null) {
            final response = await http.get(Uri.parse(
                '${AppConfig.baseUrl}/api/v1/kelas/ruang-kelas?kelas_uuid=$kelasUuid'));

            if (response.statusCode == 200) {
              final Map<String, dynamic> responseData =
                  jsonDecode(response.body);
              return responseData;
            } else {
              print("Error fetching ruang kelas: ${response.statusCode}");
              return null;
            }
          } else {
            print("Kelas UUID not found in user data");
            return null;
          }
        } else {
          print("Invalid user data or kelas information not found");
          return null;
        }
      } else {
        print("Invalid user data or data not found");
        return null;
      }
    } catch (e) {
      print("Error fetching ruang kelas: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchAbsen() async {
    try {
      Map<String, dynamic>? userData = await fetchUser();

      if (userData != null && userData.containsKey('data')) {
        Map<String, dynamic> data = userData['data'];

        if (data.containsKey('no_induk')) {
          int? noInduk = data['no_induk'];
          int bulan = DateTime.now().month;
          print("No Induk: $noInduk");

          if (noInduk != null) {
            final response = await http.get(Uri.parse(
                '${AppConfig.baseUrl}/api/v1/laporan/user-bulanan?no_induk=$noInduk&bulan=$bulan'));
            if (response.statusCode == 200) {
              final Map<String, dynamic> responseData =
                  jsonDecode(response.body);
              return responseData;
            } else {
              print("Error: ${response.statusCode}");
              return null;
            }
          } else {
            print("No Induk found in user data is null");
            return null;
          }
        } else {
          print("No Induk not found in user data");
          return null;
        }
      } else {
        print("Invalid user data or data not found");
        return null;
      }
    } catch (e) {
      print("Error fetching absen: $e");
      return null;
    }
  }
}
