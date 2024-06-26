import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;
  final bool tailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading = false,
    this.tailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blueDarkColor,
      automaticallyImplyLeading: false,
      leading: leading
          ? IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              color: backgroundColor,
              iconSize: 30,
              onPressed: () {
                Get.back();
              },
            )
          : null,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: backgroundColor),
      ),
      centerTitle: true,
      actions: tailing
          ? [
              IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                color: backgroundColor,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
