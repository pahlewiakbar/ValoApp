import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'view/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: 'asset/splash.png',
        nextScreen: const HomeView(),
        duration: 1000,
        splashIconSize: 130,
        backgroundColor: Colors.grey.shade900);
  }
}
