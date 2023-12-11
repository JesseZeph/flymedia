import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/services/helpers/forgot_password_helper.dart';
import 'package:flymedia_app/src/authentication/components/text_input_field.dart';
import 'package:flymedia_app/src/authentication/forgotpassword/screens/resetSuccessful.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../components/roundedbutton.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isloading = context.watch<ForgotPasswordHelper>().isloading;
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60.h),
                child: HeadingAndSubText(
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
                  controller: newPasswordController,
                  hintText: '',
                  onChanged: (_) {},
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (newPasswordController.text.isEmpty) {
                    context.showError('Enter new password.');
                    return;
                  }
                  await context
                      .read<ForgotPasswordHelper>()
                      .resetPassword(newPasswordController.text)
                      .then((resp) {
                    if (resp.first) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResetSuccessful(isInfluencer: resp.last),
                          ));
                    } else {
                      context.showError(resp[1]);
                    }
                  });
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
      ),
    );
  }
}
