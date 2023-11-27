import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/route/route.dart';

import '../../components/roundedbutton.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/unreadMessage.png',
                ),
                headerText: 'Check Your Email',
                subText:
                    'A verification code has been sent to your email address',
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToPage(context, '/verifyEmail');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Verify Email',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageWithTextWidget extends StatelessWidget {
  final Image assetImage;
  final String headerText;
  final String subText;

  const ImageWithTextWidget({
    super.key,
    required this.assetImage,
    required this.headerText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(width: 160.w, height: 160.h, child: assetImage),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              headerText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mainTextColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              subText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mainTextColor.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
