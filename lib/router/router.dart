import 'package:get/get.dart';

//screens
import '../app/siswa/view.dart';
import '../app/guru/view.dart';
import '../app/home/view.dart';
import '../app/qr/view.dart';
import '../app/splashscreen/splash.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/enter",
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
    GetPage(
      name: "/qrgen",
      page: () => const QrGenerate(),
      transition: Transition.cupertino,
    )
  ];
}
