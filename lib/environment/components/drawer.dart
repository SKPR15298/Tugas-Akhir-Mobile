import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../colors.dart';

class Sidebar extends StatelessWidget {
  final bool isGuru;

  const Sidebar({
    super.key,
    this.isGuru = false,
  });

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
}
