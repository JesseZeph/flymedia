import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/route/route.dart';

import '../components/roundedbutton.dart';
import '../forgotpassword/screens/checkemail.dart';

class VerifyEmailAccount extends StatelessWidget {
  const VerifyEmailAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 315.w,
              margin: EdgeInsets.only(top: 140.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/openlaptop.png',
                ),
                headerText: 'Verify your email address',
                subText:
                    'An OTP has been sent to your email address. Please check your inbox (and spam folder, just in case) to complete the verification process.',
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToPage(context, '/userEmailVerification');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Next',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
