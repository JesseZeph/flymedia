import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';

class SalaryInput extends StatelessWidget {
  final String text;
  const SalaryInput({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            ),
            Container(
              width: 93.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(top: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: AppColors.lightHintTextColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8.r)),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.lightHintTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomField extends StatelessWidget {
  final String text;
  const CustomField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            ),
            Container(
              width: 140.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(top: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: AppColors.lightHintTextColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8.r)),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.lightHintTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
