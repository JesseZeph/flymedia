import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:get/get.dart';

class RoundedButtonsWidget extends StatelessWidget {
  final String text;
  const RoundedButtonsWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.r),
        color: AppColors.mainColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.sp),
      ),
    );
  }
}
