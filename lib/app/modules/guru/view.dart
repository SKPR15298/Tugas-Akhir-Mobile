import 'package:flutter/material.dart';
import '../../core/components/appbar.dart';

class PageGuru extends StatelessWidget {
  const PageGuru({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(title: "Ruang Kelas"),
        body: Center(
          child: Text("Guru"),
        ));
  }
}
