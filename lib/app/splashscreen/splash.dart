import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../environment/colors.dart';
import '../home/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/logo.png'),
      gradientBackground: backgroundGradient,
      showLoader: true,
      loaderColor: textColor,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(color: textColor),
      ),
      durationInSeconds: 5,
      logoWidth: 150,
      navigator: const PageMain(),
    );
  }
}
