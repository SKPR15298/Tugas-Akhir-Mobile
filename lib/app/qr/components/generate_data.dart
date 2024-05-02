import 'dart:math' as math;
import 'package:intl/intl.dart';

String generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  math.Random rnd = math.Random.secure();
  return List.generate(length, (index) => charset[rnd.nextInt(charset.length)])
      .join('');
}

String generateQRData(double userLatitude, double userLongitude) {
  double centerLatitude = -7.913602;
  double centerLongitude = 112.640491;
  double radiusInMeters = 100.0;

  if (isWithinCircularArea(userLatitude, userLongitude, centerLatitude,
      centerLongitude, radiusInMeters)) {
    String randomString = generateRandomString(15);
    String timestamp = DateFormat('dd/MM/yyHHmmss').format(DateTime.now());
    return '$randomString-$timestamp';
  } else {
    return '';
  }
}

bool isWithinCircularArea(double userLatitude, double userLongitude,
    double centerLatitude, double centerLongitude, double radiusInMeters) {
  double distance = calculateDistance(
      userLatitude, userLongitude, centerLatitude, centerLongitude);
  return distance <= radiusInMeters;
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000;
  double dLat = (lat2 - lat1) * (math.pi / 180);
  double dLon = (lon2 - lon1) * (math.pi / 180);
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1 * (math.pi / 180)) *
          math.cos(lat2 * (math.pi / 180)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double distance = earthRadius * c;
  return distance;
}
