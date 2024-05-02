// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../environment/colors.dart';
import './components/card.dart';
import '../../environment/components/drawer.dart';
import '../../environment/components/appbar.dart';
import '../guru/api/api.dart';

class PageSiswa extends StatefulWidget {
  const PageSiswa({super.key});

  @override
  PageSiswaState createState() => PageSiswaState();
}

class PageSiswaState extends State<PageSiswa> {
  late DateTime _currentMonth;
  Map<String, dynamic>? userData;
  Map<String, dynamic>? absenData;
  int mode = 1;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchAbsen();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  Future<void> _fetchData() async {
    try {
      final fetchedUserData = await DataFetch.fetchUser();
      print(DateTime.now());
      setState(() {
        userData = fetchedUserData;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _fetchAbsen() async {
    try {
      final fetchedAbsen = await DataFetch.fetchAbsen();
      setState(() {
        absenData = fetchedAbsen;
      });
      print(absenData);
    } catch (e) {
      print("Error fetching user absen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Siswa", tailing: true),
      endDrawer: const Sidebar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: absenData == null || userData == null
                ? _buildSkeletonLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData!['data']['nama'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userData!['data']['kelas']['kelas'] +
                            " " +
                            userData!['data']['jurusan']['singkatan'] +
                            " " +
                            userData!['data']['kelas']['tingkat'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        width: Get.width,
                        height: Get.height * 0.095 + 40,
                        decoration: BoxDecoration(
                            gradient: buttonGradient,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/qrgen');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_scanner_rounded,
                                color: backgroundColor,
                                size: 40,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "GENERATE QR",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Riwayat Presensi Bulan: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(_currentMonth),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      if (absenData!['data']['data']['absen'].isEmpty)
                        SizedBox(
                          width: Get.width,
                          height: Get.height / 2 + 50,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/empty.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (absenData!['data']['data']['absen'].isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: absenData!['data']['data']['absen'].length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> attendance =
                                absenData!['data']['data']['absen'][index];

                            String masuk = attendance['masuk'];
                            String pulang = attendance['pulang'];

                            Status status;
                            if (masuk == 'Sudah' && pulang == 'Sudah') {
                              status = Status.lengkap;
                            } else if (masuk == 'Sudah' || pulang == 'Sudah') {
                              status = Status.kurang;
                            } else {
                              status = Status.kosong;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SiswaCard(
                                  tanggal: absenData!['data']['data']['absen']
                                      [0]['tanggal'],
                                  status: status),
                            );
                          },
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return SizedBox(
      height: Get.height * 0.6,
      child: Center(
        child: LoadingAnimationWidget.twoRotatingArc(
          color: blueColor,
          size: 50,
        ),
      ),
    );
  }
}
