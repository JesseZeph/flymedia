import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/imageStrings.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/fourthpage.dart';

import '../../../constants/textstring.dart';
import '../../../customPaint/paint.dart';
import '../../../utils/widgets/headings.dart';

class ThirdOnboard extends StatelessWidget {
  const ThirdOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 45.h,
              left: 290.w,
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed(
                    //     '/skip');
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 45.w,
              top: 115.h,
              child: Container(
                width: 300.w,
                height: 300.h,
                margin: EdgeInsets.only(top: 50.h),
                child: SvgPicture.asset(SvgImages.line),
              ),
            ),
            Positioned(
              left: 160.w,
              top: 270.h,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.line2),
              ),
            ),
            Positioned(
              left: 55.w,
              top: 125.h,
              child: Container(
                width: 250.w,
                height: 250.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.secondOnboard),
              ),
            ),
            Positioned(
              left: 91.w,
              top: 105.h,
              child: Container(
                width: 32.w,
                height: 32.h,
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.cell),
              ),
            ),
            Positioned(
              left: 290.w,
              top: 285.h,
              width: 32.w,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.bitmoji),
              ),
            ),
            Positioned(
              left: 285.w,
              top: 161.h,
              width: 32.w,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Image.asset(AppImages.handshake),
              ),
            ),
            Positioned(
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 470.h, left: 15.w),
                child: const HeadingAndSubText(
                  heading: AppTexts.colabText,
                  subText: AppTexts.colabSubText,
                ),
              ),
            ),
            Positioned(
              left: 213.w,
              top: 578.h,
              child: SizedBox(
                width: 150.w,
                height: 150.w,
                child: CustomPaint(
                  painter: Circle(),
                ),
              ),
            ),
            Positioned(
              left: 250.w,
              top: 615.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FourthOnboard()));
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
