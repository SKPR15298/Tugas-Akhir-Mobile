import 'package:flutter/material.dart';
import 'package:pressdasi/app/core/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blueColor,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        color: backgroundColor,
        iconSize: 30,
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: backgroundColor),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
