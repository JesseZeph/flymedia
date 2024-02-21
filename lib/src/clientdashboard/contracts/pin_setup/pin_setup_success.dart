import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';

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
                    'Success! Your pin has been set successfully. You can now proceed with making payments confidently. Than you for secuuring your account.',
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Make Payment',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
