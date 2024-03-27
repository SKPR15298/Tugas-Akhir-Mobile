import 'package:get/get.dart';
import 'package:pressdasi/app/modules/home/view.dart';

//screens
import './app/modules/siswa/view.dart';
import './app/modules/guru/view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: "/",
      page: () => const PageMain(),
    ),
    GetPage(
      name: "/guru",
      page: () => const PageGuru(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: "/siswa",
      page: () => const PageSiswa(),
      transition: Transition.cupertino,
    ),
  ];
}
