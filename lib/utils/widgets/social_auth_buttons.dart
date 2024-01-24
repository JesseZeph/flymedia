import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class AppleGoogleButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;
  const AppleGoogleButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        width: 150.w,
        height: 50.h,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.lightHintTextColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(25.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imagePath, width: 20.w),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.mainTextColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
