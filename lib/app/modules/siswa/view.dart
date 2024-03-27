import 'package:flutter/material.dart';
import '../../core/components/appbar.dart';

class PageSiswa extends StatelessWidget {
  const PageSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Siswa"),
      body: Center(
        child: Text("Siswa"),
      ),
    );
  }
}
