import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pressdasi/app/core/colors.dart';
import '../../core/components/appbar.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({super.key});

  @override
  State<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
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
              Container(
                height: 250,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "1. Arahkan QRcode ke scanner yang sudah tersedia di lingkungan sekolah \n",
                                  style: TextStyle(color: textColor)),
                              TextSpan(
                                  text: "2. Tunggu hingga proses berhasil\n",
                                  style: TextStyle(color: textColor)),
                              TextSpan(
                                  text: "3. Proses selesai ",
                                  style: TextStyle(color: textColor)),
                            ],
                          ),
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
