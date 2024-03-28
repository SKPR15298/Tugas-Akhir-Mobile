import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    color: blueDarkColor,
                  ),
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
                        'Item 1',
                        style: TextStyle(
                          color: backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {},
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
                          Get.offAllNamed("/");
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
}
