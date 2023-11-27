import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:unicons/unicons.dart';

import '../screens/widgets/appbar.dart';
import '../screens/widgets/welcomeWidget.dart';

class Campaign extends StatelessWidget {
  const Campaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const FlyAppBar(),
      ),
      backgroundColor: AppColors.lightHintTextColor.withOpacity(0.02),
      body: Center(
        child: Column(
          children: [
            const ClientTopWidget(
              subText: "Let's find the best talent for you.",
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                // navigateToPage(context, '/');
              },
              child: Container(
                width: 321.w,
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.r),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: AppColors.lightHintTextColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 4.r, horizontal: 2.r),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.2)),
                      child: const Icon(
                        FluentSystemIcons.ic_fluent_add_filled,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Post a campaign',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.mainTextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 321.w,
              margin: EdgeInsets.only(top: 20.h),
              child: Text(
                'Posted Campaigns',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mainTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToPage(context, '/viewCampaign');
              },
              child: Container(
                width: 321.w,
                margin: EdgeInsets.only(top: 15.h),
                padding: EdgeInsets.symmetric(
                  vertical: 10.w,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.all(5.w),
                      child: CircleAvatar(
                        backgroundColor: AppColors.dialogColor,
                        radius: 50.w,
                        child: Icon(
                          UniconsLine.user,
                          color: AppColors.hintTextColor,
                          size: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiktok Influencer for a Skincare Brand',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                        ),
                        Text(
                          'Mooi',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.lightMainText,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12.sp,
                                  ),
                        ),
                        Text(
                          'Singapore',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.lightMainText,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
