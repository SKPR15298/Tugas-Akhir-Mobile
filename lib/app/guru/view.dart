// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../environment/components/appbar.dart';
import '../../environment/components/drawer.dart';
import './components/card.dart';
import '../../environment/colors.dart';
import './api/api.dart';

class PageGuru extends StatefulWidget {
  const PageGuru({Key? key}) : super(key: key);

  @override
  PageGuruState createState() => PageGuruState();
}

class PageGuruState extends State<PageGuru> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? kelasData;
  bool _fetchKelasCalled = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedUserData = await DataFetch.fetchUser();
      setState(() {
        userData = fetchedUserData;
      });
      if (userData != null && !_fetchKelasCalled) {
        print("Fetched user data: $userData");
        await _fetchKelas();
        _fetchKelasCalled = true;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _fetchKelas() async {
    try {
      final fetchedKelasData = await DataFetch.fetchKelas();
      if (fetchedKelasData != null) {
        setState(() {
          kelasData = fetchedKelasData;
        });
        print("Fetched kelas data: $fetchedKelasData");
      }
    } catch (e) {
      print("Error fetching kelas data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Ruang Kelas",
        tailing: true,
      ),
      endDrawer: const Sidebar(isGuru: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: kelasData == null || userData == null
                ? _buildSkeletonLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kelasData!['data']['wali_kelas'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kelasData!['data']['kelas'] +
                                " " +
                                kelasData!['data']['jurusan_singkatan'] +
                                " " +
                                kelasData!['data']['tingkat'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: kelasData!['data']['member']
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: textColor,
                                  ),
                                ),
                                const TextSpan(
                                  text: " Siswa",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hari",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('dd/MM/yyyy').format(now),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      if (kelasData!['data']['member'].isEmpty)
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
                      if (kelasData!['data']['member'].isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: kelasData!['data']['member'].length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> attendance =
                                kelasData!['data']['member'][index];

                            String detail = attendance['hex_absen'];

                            Status absen;
                            if (detail == '#949494') {
                              absen = Status.kosong;
                            } else if (detail == '#2F9D14') {
                              absen = Status.lengkap;
                            } else {
                              absen = Status.kurang;
                            }
                            final member = kelasData!['data']['member'][index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GuruCard(
                                status: absen,
                                namaSiswa: member['nama'],
                              ),
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
