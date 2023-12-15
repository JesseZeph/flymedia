import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/clientAuth/authenticationview.dart';

import '../../components/roundedbutton.dart';
import '../../forgotpassword/screens/checkemail.dart';

class UserVerificationSuccessful extends StatelessWidget {
  const UserVerificationSuccessful({Key? key}) : super(key: key);

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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationView(),
                    ),
                    (route) => false);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Back to login',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
