import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 129.w,
          child: Divider(
            color: AppColors.lightHintTextColor.withOpacity(0.3),
            thickness: 1,
          ),
        ),
        const Text('or'),
        SizedBox(
          width: 129.w,
          child: Divider(
            color: AppColors.lightHintTextColor.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class FullDivider extends StatelessWidget {
  const FullDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 352.w,
          child: Divider(
            color: AppColors.lightHintTextColor.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
