// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../environment/colors.dart';
import './api/api.dart';

class PageMain extends StatelessWidget {
  const PageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.1),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "SELAMAT DATANG!\n",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: backgroundColor,
                          ),
                        ),
                        TextSpan(
                          text: "Pressdasi Mobile",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.09),
              SizedBox(
                height: Get.height * 0.4,
                child: Image.asset(
                  'assets/inorasiicon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      const Verification(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: blueColor,
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Pastikan sudah memiliki akun',
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  final TextEditingController _noindukController = TextEditingController();

  @override
  void dispose() {
    _noindukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 4,
              ),
            ),
            const Center(
              child: Text(
                'Masukkan kode identifikasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _noindukController,
                        style: const TextStyle(color: textColor),
                        autofocus: true,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) async {
                          final String noinduk = _noindukController.text;

                          try {
                            await NoInduk().getNoInduk(noinduk);
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black54,
                          ),
                          hintText: 'Masukkan NISN/NIP(Guru)',
                          hintStyle: TextStyle(
                            color: greyColor,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: textColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: blueColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final String noinduk = _noindukController.text;

                          try {
                            await NoInduk().getNoInduk(noinduk);
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: blueColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          child: Text(
                            'Lanjut',
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 12,
                            ),
                          ),
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
    );
  }
}
