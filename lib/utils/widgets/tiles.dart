import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';

class TilesWidget extends StatelessWidget {
  final String title;
  const TilesWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.tileColor,
      ),
      margin: EdgeInsets.only(left: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(FontAwesomeIcons.checkDouble, color: AppColors.greenTick, size: 16.w,),
          SizedBox(width: 10.w),
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.hintTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
