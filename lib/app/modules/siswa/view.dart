import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/colors.dart';
import './components/card.dart';
import '../../core/components/appbar.dart';

class PageSiswa extends StatelessWidget {
  const PageSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Siswa", tailing: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wahyu Sheva Kurnia Pratama Rachman",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  "XII RPL 2",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  height: Get.height * 0.095 + 40,
                  decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                TableCalendar(
                  focusedDay: DateTime.now()
                      .subtract(Duration(days: DateTime.now().day)),
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.now().month == DateTime.now().month
                      ? DateTime.now()
                          .subtract(Duration(days: DateTime.now().day))
                      : DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  daysOfWeekVisible: false,
                  rowHeight: 0,
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: SiswaCard(),
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
