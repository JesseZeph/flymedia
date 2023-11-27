import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:pinput/pinput.dart';

import '../../../../route/route.dart';
import '../../components/roundedbutton.dart';

class VerifyEmail extends StatelessWidget {
  VerifyEmail({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 45.w,
        height: 45.h,
        margin: EdgeInsets.only(top: 40.w),
        textStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
            color: AppColors.lightHintTextColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.r)));

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(
        10.r,
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80.h),
                child: ImageWithTextWidget(
                    assetImage: Image.asset('assets/images/unreadMessage.png'),
                    headerText: 'Verify your email address',
                    subText:
                        'Enter the 6 digits OTP sent to your email address'),
              ),
              Align(
                child: Form(
                  key: formKey,
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    controller: pinController,
                    obscureText: true,
                    length: 6,
                    showCursor: false,
                    onChanged: (_) {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: Text(
                  "Didn't receive OTP?",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 12.sp),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                      ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateToPage(context, '/resetPassword');
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: const RoundedButtonWidget(
                    title: 'Verify',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
