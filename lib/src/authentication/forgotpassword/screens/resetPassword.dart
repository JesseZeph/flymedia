import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/components/text_input_field.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';

import '../../../../constants/colors.dart';
import '../../../../route/route.dart';
import '../../components/roundedbutton.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
                  heading: 'Reset Password',
                  subText: 'Enter your new password.'),
            ),
            Container(
              width: 314.w,
              padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mainTextColor, fontSize: 12.sp),
                ),
              ),
            ),
            Container(
              width: 314.w,
              padding: EdgeInsets.only(bottom: 35.h),
              child: TextInputField(
                hintText: '',
                onChanged: (_) {},
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateToPage(context, '/resetSuccessful');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: const RoundedButtonWidget(
                  title: 'Confirm',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
