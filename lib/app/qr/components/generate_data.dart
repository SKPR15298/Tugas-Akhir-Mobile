import 'dart:math';
import 'package:intl/intl.dart';

String generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random.secure();
  return List.generate(length, (index) => charset[rnd.nextInt(charset.length)])
      .join('');
}

String generateQRData() {
  String randomString = generateRandomString(15);
  String timestamp = DateFormat('dd/mm/yyhhmmss').format(DateTime.now());
  return '$randomString-$timestamp';
}
