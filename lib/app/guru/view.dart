// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../environment/components/appbar.dart';
import '../../environment/components/drawer.dart';
import './components/card.dart';
import '../../environment/colors.dart';
import './api/api.dart';

class PageGuru extends StatefulWidget {
  const PageGuru({super.key});

  @override
  PageGuruState createState() => PageGuruState();
}

class PageGuruState extends State<PageGuru> {
  Map<String, dynamic> userData = {};

  Future<void> _fetchData() async {
    try {
      Map<String, dynamic>? fetchedData = await DataFetch.fetchUser();
      print("fetch data: $fetchedData");
      setState(() {
        userData = fetchedData!;
      });
    } catch (e) {
      print("Error: Failed to fetch user data - $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    int mode = 0;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '<Nama>',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "XII RPL 2",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "1 ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: textColor,
                            ),
                          ),
                          TextSpan(
                            text: "Siswa",
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
                if (mode == 0)
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
                if (mode == 1)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: GuruCard(status: Status.lengkap),
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
}
