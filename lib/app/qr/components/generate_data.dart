// ignore_for_file: avoid_print

import 'dart:math' as math;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getStoredUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uuid = prefs.getString('uuid');
  return uuid;
}

String generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  math.Random rnd = math.Random.secure();
  return List.generate(length, (index) => charset[rnd.nextInt(charset.length)])
      .join('');
}

Future<String> generateQRData(
    {required String masuk, required String pulang}) async {
  String randomString = generateRandomString(5);
  String timestamp = DateFormat('dd/MM/yyHHmmss').format(DateTime.now());
  String? uuid = await getStoredUUID();

  String status = getStatus(masuk, pulang);

  Map<String, dynamic> qrData = {
    'status': status,
    'uuid': uuid,
    'time': timestamp,
    'random': randomString
  };

  String jsonString = jsonEncode(qrData);
  print(jsonString);
  return jsonString;
}

String getStatus(String masuk, String pulang) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('HH:mm:ss');
  DateTime parsedMasukTime = formatter.parse(masuk);
  DateTime parsedPulangTime = formatter.parse(pulang);

  if (now.isBefore(parsedMasukTime)) {
    return 'masuk';
  } else if (now.isAfter(parsedPulangTime)) {
    return 'pulang';
  } else {
    return '';
  }
}
