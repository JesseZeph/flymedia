import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class HeadingAndSubText extends StatelessWidget {
  final String heading;
  final String subText;
  const HeadingAndSubText({
    super.key,
    required this.heading,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 310.w,
          margin: EdgeInsets.only(top: 20.h),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
            subText,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.lightMainText,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                  height: 1.6,
                ),
          ),
        ),
      ],
    );
  }
}

class DashHeadingAndSubText extends StatelessWidget {
  final String heading;
  final String subText;
  const DashHeadingAndSubText({
    super.key,
    required this.heading,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 325.w,
          margin: EdgeInsets.only(top: 10.h),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.mainTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
          ),
        ),
        Container(
          width: 325.w,
          margin: EdgeInsets.only(top: 10.h),
          child: Text(
            subText,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.lightMainText,
                  fontWeight: FontWeight.w100,
                  fontSize: 12.sp,
                  height: 1.6,
                ),
          ),
        ),
      ],
    );
  }
}

class CustomHeader extends StatelessWidget {
  final String heading;
  final String subText;
  const CustomHeader({
    super.key,
    required this.heading,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Text(
            heading,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.mainTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            subText,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.lightMainText,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.sp,
                  height: 1.6,
                ),
          ),
        ),
      ],
    );
  }
}
