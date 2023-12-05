import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';

import '../../authentication/components/roundedbutton.dart';

class CampaignLive extends StatelessWidget {
  const CampaignLive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 130.h,
                bottom: 16.h,
              ),
              child: Image.asset(
                'assets/images/confetti.png',
                width: 200.w,
                height: 150.h,
              ),
            ),
            Text(
              AppTexts.campaignLiveHeader,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mainTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Container(
              width: 320.w,
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                AppTexts.campaignLiveSubText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.lightMainText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            GestureDetector(
              onTap: () {
                print("Tapped");
              },
              child: const RoundedButtonWidget(
                title: 'Go to Homepage',
              ),
            )
          ],
        ),
      ),
    );
  }
}
