import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/src/clientdashboard/client_home_page.dart';
import 'package:flymedia_app/src/influencerDashboard/influencer_homepage.dart';

import '../../components/roundedbutton.dart';
import 'checkemail.dart';

class ResetSuccessful extends StatelessWidget {
  final bool isInfluencer;

  const ResetSuccessful({Key? key, required this.isInfluencer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/tick.png',
                ),
                headerText: 'Password Changed',
                subText: 'You have successfully reset your password',
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isInfluencer) {
                  pushToAndClearStack(context, const InfluencerHomePage());
                } else {
                  pushToAndClearStack(context, const ClientHomePage());
                }
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const ClientHomePage(),
                //   ),
                // );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Continue',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
