import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:get/get.dart';

class PinSetupSuccess extends StatefulWidget {
  const PinSetupSuccess({
    Key? key,
  }) : super(key: key);

  @override
  State<PinSetupSuccess> createState() => _PinSetupSuccessState();
}

class _PinSetupSuccessState extends State<PinSetupSuccess> {
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
                headerText: 'Pin Successfully Set',
                subText:
                    'Success! Your pin has been set successfully. Thank you for securing your account.',
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: true);
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
