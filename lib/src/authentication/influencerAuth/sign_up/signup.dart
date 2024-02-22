import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/signup_provider.dart';
import 'package:flymedia_app/models/requests/auth/signup.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/emailfield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/namefield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/passwordfield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/social_buttons.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/sign_up/button.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/textstring.dart';
import '../../../../utils/widgets/checkbox.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';
import '../influencerverification/verifyemailaddress.dart';

class InfluencerSignUp extends StatefulWidget {
  const InfluencerSignUp({super.key});

  @override
  State<InfluencerSignUp> createState() => _SignUpState();
}

class _SignUpState extends State<InfluencerSignUp> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool agreedToTerms = false;

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h, bottom: 32.h),
          child: const HeadingAndSubText(
            heading: AppTexts.createAccountHeaderText,
            subText: AppTexts.createAccountSubText,
          ),
        ),
        const SocialAuth(
          isSignUp: true,
          userIsClient: false,
        ),
        SizedBox(height: 32.h),
        const DividerWidget(),
        SizedBox(height: 25.h),
        NameField(
          fullname: fullname,
        ),
        SizedBox(
          height: 25.h,
        ),
        EmailField(
          email: email,
        ),
        SizedBox(
          height: 25.h,
        ),
        PasswordField(
          password: password,
        ),
        SizedBox(
          height: 25.h,
        ),
        PasswordField(
          text: 'Confirm Password',
          password: confirmPassword,
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: CheckWidget(
            onPressed: (val) => agreedToTerms = val ?? false,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        InfluencerSignUpButton(onTap: () async {
          if (password.text != confirmPassword.text) {
            context.showError('Passwords do not match.');
            return;
          }
          if (fullname.text.isEmpty ||
              email.text.isEmpty ||
              password.text.isEmpty) {
            context.showError('One or more fields are empty.');
            return;
          } else if (!agreedToTerms) {
            context.showError('Agree to Terms of Service.');
            return;
          } else if (password.text.length < 6) {
            context.showError('Password should be at least 6 characters.');
            return;
          }
          SignupModel model = SignupModel(
              fullname: fullname.text,
              email: email.text,
              password: password.text);
          String newModel = signupModelToJson(model);
          await context
              .read<SignUpNotifier>()
              .influencerSignup(newModel)
              .then((success) {
            if (success) {
              Get.offAll(() => const InfluencerVerifyEmail());
            } else {
              context.showError("Sign up failed. Try again later.");
            }
          });
        }),
      ],
    );
  }
}
