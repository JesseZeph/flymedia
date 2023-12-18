import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/imageStrings.dart';
import 'package:flymedia_app/src/onboardingscreen/onboardpages/thirdpage.dart';

import '../../../constants/textstring.dart';
import '../../../customPaint/paint.dart';

class SecondOnboard extends StatelessWidget {
  const SecondOnboard({super.key});

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
            //         Navigator
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
              left: 30.w,
              top: 100.h,
              child: Container(
                width: 300.w,
                height: 300.h,
                margin: EdgeInsets.only(top: 50.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.r),
                    color: AppColors.mainColor.withAlpha((0.6 * 255).round())),
              ),
            ),
            Positioned(
              left: 55.w,
              top: 125.h,
              child: Container(
                width: 250.w,
                height: 250.h,
                margin: EdgeInsets.only(top: 50.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.r),
                  color: AppColors.lightMain,
                ),
              ),
            ),
            Positioned(
                left: 80.w,
                top: 150.h,
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.r),
                    image: const DecorationImage(
                      image: AssetImage(AppImages.onboarding),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
                left: 25.w,
                top: 290.h,
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.r),
                    image: const DecorationImage(
                      image: AssetImage(AppImages.firstOnboard),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
              left: 245.w,
              top: 395.h,
              child: Container(
                width: 90.w,
                height: 32.h,
                decoration: ShapeDecoration(
                  color: AppColors.dialogColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 7.w),
                  child: Text(
                    "Let's do this! 🎉",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.dialogBlue,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              // left: 210.w,
              right: 0.w,
              top: 150.h,
              child: Container(
                // width: 130.w,
                // height: 40.h,
                padding: EdgeInsets.only(left: 7.w, top: 5.h, right: 5.w),
                decoration: ShapeDecoration(
                  color: AppColors.dialogColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                ),
                //TODO: you overflow here on a smaller screen size, you could fix it
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.r),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.sophieEllipse),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@Sophiee2',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.mainTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(height: 3.w),
                          Text(
                            '100.2k followers',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.lightMainText,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 470.h, left: 15.w),
                child: Column(
                  children: [
                    Container(
                      width: 310.w,
                      margin: EdgeInsets.only(top: 20.h),
                      child: Text(
                        AppTexts.brandText,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppColors.mainTextColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                      ),
                    ),
                    Container(
                      width: 310.w,
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        AppTexts.welcomeText,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppColors.mainTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  height: 1.6,
                                ),
                      ),
                    ),
                  ],
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
                  painter: SemiArcPainter(),
                ),
              ),
            ),
            Positioned(
              left: 250.w,
              top: 615.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ThirdOnboard()));
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
