import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';

import '../../../constants/imageStrings.dart';

class VerificationInProgress extends StatelessWidget {
  const VerificationInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100.h, bottom: 20.h),
            child: Image.asset(AppImages.rafiki, width: 200.w, height: 150.h),
          ),
          Text(
            'Verification In Progress',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainTextColor,
                ),
          ),
          Container(
            width: 320.w,
            margin: EdgeInsets.only(top: 10.h),
            child: Text(
              AppTexts.verifyProgress,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightMainText,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       pushToAndClearStack(context, ClientHomePage());
          //     },
          //     child: Text('Go back to dashboard'))
        ],
      )),
    );
  }
}
