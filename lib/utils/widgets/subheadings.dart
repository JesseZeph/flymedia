import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class Headings extends StatelessWidget {
  final String text;
  const Headings({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 8.h),
      width: 325.w,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class SubHeadings extends StatelessWidget {
  final String text;
  const SubHeadings({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 8.h),
      width: 325.w,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

class InfluencerSubHeading extends StatelessWidget {
  final String text;
  const InfluencerSubHeading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 8.h),
      width: 325.w,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class CHeadingAndSubText extends StatelessWidget {
  final String heading;
  final String subText;
  const CHeadingAndSubText({
    super.key,
    required this.heading,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 8.h),
      width: 325.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 5.w),
          Text(
            subText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.lightMainText,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ],
      ),
    );
  }
}
