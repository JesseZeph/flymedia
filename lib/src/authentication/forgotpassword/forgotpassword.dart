import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';

import '../components/animated_button.dart';
import '../components/roundedbutton.dart';
import '../components/text_input_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60.h),
              child: const HeadingAndSubText(
                heading: AppTexts.forgotPasswordHeader,
                subText: AppTexts.forgotPasswordSubText,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                  child: Text(
                    'Email address',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp, color: AppColors.mainTextColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: TextInputField(
                    hintText: 'Enter your email address',
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            AnimatedButton(
              onTap: () {
                navigateToPage(context, '/checkEmail');
              },
              child: const RoundedButtonWidget(
                title: 'Send Code',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mainTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
