import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../colors.dart';
import '../../app/guru/api/api.dart';

class Sidebar extends StatelessWidget {
  final bool isGuru;

  const Sidebar({
    Key? key,
    this.isGuru = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top + 55,
            decoration: const BoxDecoration(
              color: blueDarkColor,
            ),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: const Center(
              child: Text(
                'PRESSDASI: Mobile',
                style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: blueDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      autofocus: true,
                      leading: const Icon(
                        Icons.home_filled,
                        color: backgroundColor,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                          color: backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                if (isGuru == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        autofocus: true,
                        leading: const Icon(
                          Icons.file_download,
                          color: textColor,
                        ),
                        title: const Text(
                          'Laporan',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          _showMonthSelector(context);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: greyColor.withOpacity(0.5)),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Yakin, untuk keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Tidak',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GetStorage().erase();
                          Get.offAllNamed("/enter");
                        },
                        child: Text(
                          'Ya',
                          style: TextStyle(
                            color: redColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: redColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthSelector(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    DateTime displayedMonth = selectedDate;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                '${_getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          displayedMonth = DateTime(
                              displayedMonth.year, displayedMonth.month - 1);
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime startDate = DateTime(
                            displayedMonth.year, displayedMonth.month, 1);
                        DateTime endDate = DateTime(
                            displayedMonth.year, displayedMonth.month + 1, 0);

                        // Format startDate and endDate
                        String formattedStartDate =
                            DateFormat('yyyyMMdd').format(startDate);
                        String formattedEndDate =
                            DateFormat('yyyyMMdd').format(endDate);

                        File? jadwalFile = await DataFetch.fetchJadwal(
                            formattedStartDate, formattedEndDate);
                        if (jadwalFile != null) {
                        } else {}
                      },
                      child: const Text('Unduh'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        setState(() {
                          displayedMonth = DateTime(
                              displayedMonth.year, displayedMonth.month + 1);
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );

    print(
        'Selected month: ${_getMonthName(selectedDate.month)} ${selectedDate.year}');
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
