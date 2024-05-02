import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import '../../environment/components/appbar.dart';
import '../../environment/colors.dart';
import './components/generate_data.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  State<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
  late Timer _timer;
  String qrData = '';

  @override
  void initState() {
    super.initState();
    _updateQRData();
    _startTimer();
    _disableCapture();
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

  void _updateQRData() {
    // Get user's current location (You need to implement this part)
    double userLatitude = 0.0;
    double userLongitude = 0.0;
    qrData = generateQRData(userLatitude, userLongitude);
    setState(() {});
  }

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
                    child: QrImageView(
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
