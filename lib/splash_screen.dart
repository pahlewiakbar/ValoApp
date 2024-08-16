import 'package:flutter/material.dart';

import 'view/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: Center(
              child: Image.asset(
                'asset/splash.png',
                width: 100,
              ),
            ),
          );
        }
        return const HomeView();
      },
    );
  }
}
