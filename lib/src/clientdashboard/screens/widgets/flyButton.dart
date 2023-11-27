import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';

class FlyButtons extends StatelessWidget {
  final VoidCallback onBackButtonPressed;
  final VoidCallback onSubmitButtonPressed;
  final String? backText;
  final String? submitText;
  const FlyButtons({
    super.key,
    required this.onBackButtonPressed,
    required this.onSubmitButtonPressed,
    this.backText,
    this.submitText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      margin: EdgeInsets.only(top: 30.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onBackButtonPressed,
            child: Container(
              width: 155.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  width: 1,
                  color: AppColors.lightMainText.withOpacity(0.3),
                ),
              ),
              child: Text(
                backText ?? 'Back',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onSubmitButtonPressed,
            child: Container(
              width: 155.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Text(
                submitText ?? 'Submit',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
