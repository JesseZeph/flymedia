import 'package:flutter/material.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/thirdpage.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/secondpage.dart';

import 'onboardpages/fourthpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: const [
         // FirstOnboard(),
          SecondOnboard(),
          ThirdOnboard(),
          FourthOnboard(),
        ],
      ),
    );
  }
}