import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencer_view.dart';
import 'package:get/get.dart';

import '../../components/roundedbutton.dart';

class InfluencerVerifySuccess extends StatelessWidget {
  const InfluencerVerifySuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 315.w,
              margin: EdgeInsets.only(top: 120.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/tick.png',
                ),
                headerText: 'Account Verified',
                subText:
                    'Your account has been successfully set up. Welcome to Flymedia!',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => const InfluencerAuthView());
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Back to log in',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
