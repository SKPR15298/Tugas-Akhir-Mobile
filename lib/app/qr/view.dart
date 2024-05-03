// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pressdasi/app/guru/api/api.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../../environment/components/appbar.dart';
import '../../environment/colors.dart';
import './components/generate_data.dart';
import './api/api.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  State<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
  Map<String, dynamic>? jadwalAbsen;
  late Timer _timer;
  bool isLoading = true;
  String qrData = '';
  // Position? currentPosition;
  // final double fixedLatitude = -7.913710;
  // final double fixedLongitude = 112.640610;

  @override
  void initState() {
    super.initState();
    // _requestLocationPermission();
    _startTimer();
    _disableCapture();
    _fetchJadwal();
  }

  Future<void> _fetchJadwal() async {
    try {
      final fetchedAbsen = await AbsenFetch.fetchJadwal();
      setState(() {
        jadwalAbsen = fetchedAbsen;
      });
      print("ini jadwal :$jadwalAbsen");
    } catch (e) {
      print("Error fetching absen: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      _updateQRData();
    });
  }

  void _disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> _updateQRData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (jadwalAbsen != null && jadwalAbsen!.containsKey('data')) {
        String masukTime = jadwalAbsen!['data']['masuk'];
        String pulangTime = jadwalAbsen!['data']['pulang'];
        print("ini masuk: $masukTime");
        print("ini pulang: $pulangTime");
        qrData = await generateQRData(masuk: masukTime, pulang: pulangTime);
      } else {
        print('Jadwal Absen not available or invalid format.');
      }
    } catch (e) {
      print('Error generating QR data: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  // bool _isValidLocation(Position position) {
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;
  //   double distance = Geolocator.distanceBetween(
  //       latitude, longitude, fixedLatitude, fixedLongitude);
  //   return distance <= 125;
  // }

  // void _requestLocationPermission() async {
  //   PermissionStatus permission = await Permission.location.request();
  //   if (permission.isGranted) {
  //     try {
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       setState(() {
  //         currentPosition = position;
  //       });
  //     } catch (e) {
  //       print('Error getting location: $e');
  //     }
  //   } else {
  //     print('Location permission denied');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "QR Code", leading: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator() // Show loading indicator while QR code is being generated
                        : QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 200,
                            gapless: true,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: blueDarkColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Tata Cara",
                            style: TextStyle(
                              color: backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1. Arahkan QRcode ke scanner yang sudah tersedia di lingkungan sekolah,",
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "2. Tunggu hingga proses berhasil, ",
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "3. Proses selesai. ",
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
