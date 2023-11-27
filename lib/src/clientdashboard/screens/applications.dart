import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../utils/widgets/headings.dart';

class Applications extends StatelessWidget {
  final int value;
  const Applications({super.key, this.value = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const DashHeadingAndSubText(
              heading: 'Applications',
              subText: 'Send messages to influencers that fit your campaign.',
            ),
            SizedBox(height: 25.h),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 10.w, bottom: 15.h),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: AppColors.lightHintTextColor.withOpacity(0.2),
                  width: 1,
                ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.all(5.w),
                      child: CircleAvatar(
                        radius: 37.5.w,
                        backgroundColor: AppColors.mainColor,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/secondOnboard.png',
                            width: 75.w,
                            height: 75.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lexy Chang',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '500k Followers',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.lightMainText,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12.sp,
                                  ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
