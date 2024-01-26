import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ContractCardWidget extends StatelessWidget {
  final String heading;
  final String amount;
  final String name;
  final String buttonText;
  final Color buttonColor;
  final String status;
  final void Function()? onTap;
  const ContractCardWidget({
    super.key,
    required this.heading,
    required this.amount,
    required this.name,
    required this.buttonText,
    required this.buttonColor,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onTap: onTap,
      child: FittedBox(
        child: Container(
          width: Get.width.w,
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.lightMainText.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                heading,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                softWrap: true,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const ShapeDecoration(
                        shape: OvalBorder(), color: AppColors.mainColor),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      amount,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const ShapeDecoration(
                        shape: OvalBorder(), color: AppColors.cardColor2),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                width: 100.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomKarlaText(
                  text: buttonText,
                  color: Colors.white,
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomKarlaText(
                  text: status,
                  size: 12.sp,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
