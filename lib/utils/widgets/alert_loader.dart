import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';

class AlertLoader extends StatelessWidget {
  const AlertLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
            width: 30.h,
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.mainColor, size: 30),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Posting Campaign...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mainTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
