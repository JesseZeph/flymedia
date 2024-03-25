import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/services/helpers/forgot_password_helper.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/checkemail.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../route/route.dart';
import '../../components/roundedbutton.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController pinController = TextEditingController();

  bool showResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    await Future.delayed(const Duration(seconds: 20), () {
      if (!mounted) return;
      setState(() {
        showResend = true;
      });
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isloading = context.watch<ForgotPasswordHelper>().isloading;
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
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80.h),
                  child: ImageWithTextWidget(
                      assetImage:
                          Image.asset('assets/images/unreadMessage.png'),
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
                      onCompleted: (value) async {
                        await context
                            .read<ForgotPasswordHelper>()
                            .verifyOTP(value)
                            .then((resp) {
                          if (resp.first) {
                            navigateToPage(context, '/resetPassword');
                          } else {
                            context.showError(resp.last);
                          }
                        });
                      },
                      onChanged: (_) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter code.';
                        } else if (value.length < 6) {
                          return 'Code is incomplete';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: showResend,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Text(
                      "Didn't receive OTP?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
                Visibility(
                  visible: showResend,
                  child: TextButton(
                    onPressed: () async {
                      await context
                          .read<ForgotPasswordHelper>()
                          .forgotPassword(
                              context.read<ForgotPasswordHelper>().mail ?? '')
                          .then((resp) {
                        if (resp.first) {
                          context.showSuccess('Code sent! Check your mailbox');
                          pinController.clear();
                        } else {
                          context.showError(resp.last);
                        }
                      });
                    },
                    child: Text(
                      "Resend OTP",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await context
                          .read<ForgotPasswordHelper>()
                          .verifyOTP(pinController.text)
                          .then((resp) {
                        if (resp.first) {
                          navigateToPage(context, '/resetPassword');
                        } else {
                          context.showError(resp.last);
                        }
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: showResend ? 10.h : 40.h),
                    child: const RoundedButtonWidget(
                      title: 'Verify',
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
