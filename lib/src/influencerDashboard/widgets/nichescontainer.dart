import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';

class NichesWidget extends StatelessWidget {
  final String text;
  const NichesWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 10.w),
      child: Chip(
        label: Text(
          text, // Add the text value here
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.mainColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
