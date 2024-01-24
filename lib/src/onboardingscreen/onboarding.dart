import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/onboarding_provider.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/firstpage.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/secondpage.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/thirdpage.dart';
import 'package:provider/provider.dart';

import 'onboardpages/fourthpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageViewController = PageController();

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardNotifier>(
      builder: (context, onBoardNotifier, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                onPageChanged: (page) {
                  onBoardNotifier.isLastPage = page == 2;
                },
                controller: _pageViewController,
                children: const [
                  FirstOnboard(),
                  SecondOnboard(),
                  ThirdOnboard(),
                  FourthOnboard(),
                ],
              ),
              // Positioned(
              //     bottom: 40.h,
              //     left: 155.w,
              //     child: SmoothPageIndicator(
              //       controller: _pageViewController,
              //       count: 3,
              //       effect: WormEffect(
              //           dotColor: AppColors.lightHintTextColor,
              //           activeDotColor: AppColors.mainColor,
              //           dotHeight: 12.h,
              //           dotWidth: 12.w,
              //           spacing: 10.w),
              //     ))
            ],
          ),
        );
      },
    );
  }
}
