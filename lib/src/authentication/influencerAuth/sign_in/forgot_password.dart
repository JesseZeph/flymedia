import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/route/route.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPage(context, '/passwordReset');
      },
      child: Text(
        'Forgot your password?',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.mainColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
