import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';

class CustomPreview extends StatelessWidget {
  final String text;
  final String headerText;

  const CustomPreview({
    super.key,
    required this.text,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.mainTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 15.h),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.hintTextColor,
                  fontSize: 12.sp,
                ),
          ),
        ],
      ),
    );
  }
}
