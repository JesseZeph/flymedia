import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/image_strings.dart';
import 'package:flymedia_app/src/accountoption/view.dart';

import '../../../constants/textstring.dart';
import '../../../customPaint/paint.dart';
import '../../../utils/widgets/headings.dart';

class FourthOnboard extends StatelessWidget {
  const FourthOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            // Positioned(
            //   top: 45.h,
            //   left: 290.w,
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: TextButton(
            //       onPressed: () {
            //         Navigator.of(context).pushReplacementNamed(
            //             '/skip'); // Use MaterialPageRoute for navigation
            //       },
            //       child: Text(
            //         'Skip',
            //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
            //               color: AppColors.mainColor,
            //               fontWeight: FontWeight.w700,
            //               fontSize: 12.sp,
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 10.w,
              top: 80.h,
              child: Container(
                width: 325.w,
                height: 325.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.fourthOnboard),
              ),
            ),
            Positioned(
              left: 222.w,
              top: 215.h,
              child: Container(
                width: 32.w,
                height: 32.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.love),
              ),
            ),
            Positioned(
              left: 250.w,
              top: 290.h,
              child: Container(
                width: 32.w,
                height: 32.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Text(
                  '🥰',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
            Positioned(
              left: 80.w,
              top: 150.h,
              child: Container(
                width: 32.w,
                height: 32.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Text(
                  '😀',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
            Positioned(
              left: 65.w,
              top: 270.h,
              width: 50.w,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.shinyTictok),
              ),
            ),
            Positioned(
              left: 210.w,
              top: 108.h,
              width: 50.w,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.shinyTictok),
              ),
            ),
            Positioned(
              left: 225.w,
              top: 345.h,
              width: 32.w,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.tikTok),
              ),
            ),
            Positioned(
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 470.h, left: 15.w),
                child: const HeadingAndSubText(
                  heading: AppTexts.connectHeader,
                  subText: AppTexts.connectSubText,
                ),
              ),
            ),
            Positioned(
              left: 205.w,
              top: 578.h,
              child: SizedBox(
                width: 150.w,
                height: 150.w,
                child: CustomPaint(
                  painter: FullCircle(),
                ),
              ),
            ),
            Positioned(
              left: 242.w,
              top: 615.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AccountOption()));
                },
                child: Container(
                  width: 75.w,
                  height: 75.w,
                  decoration: const ShapeDecoration(
                      color: AppColors.mainColor, shape: OvalBorder()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 35.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
