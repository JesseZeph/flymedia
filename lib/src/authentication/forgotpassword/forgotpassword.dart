import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/services/helpers/forgot_password_helper.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../components/animated_button.dart';
import '../components/roundedbutton.dart';
import '../components/text_input_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isloading = context.watch<ForgotPasswordHelper>().isloading;
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: const AlertLoader(message: 'Please wait...'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60.h),
                child: HeadingAndSubText(
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
                      controller: emailCtrl,
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
                onTap: () async {
                  if (emailCtrl.text.isEmpty) {
                    context.showSnackBar("Please add a recovery mail.");
                    return;
                  }
                  context.read<ForgotPasswordHelper>().recoverMail =
                      emailCtrl.text;
                  await context
                      .read<ForgotPasswordHelper>()
                      .forgotPassword(emailCtrl.text)
                      .then((resp) {
                    if (resp.first) {
                      navigateToPage(context, '/checkEmail');
                    } else {
                      context.showError(resp.last);
                    }
                  });
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
      ),
    );
  }
}
