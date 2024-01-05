import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/signup_provider.dart';
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
        Container(
          margin: EdgeInsets.only(top: 50.h, bottom: 32.h),
          child: HeadingAndSubText(
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
          height: 40.h,
        ),
        CheckWidget(
          onPressed: (val) => agreedToTerms = val ?? false,
        ),
        SizedBox(
          height: 15.h,
        ),
        InfluencerSignUpButton(onTap: () async {
          if (fullname.text.isEmpty ||
              email.text.isEmpty ||
              password.text.isEmpty) {
            context.showError('One or more fields are empty.');
            return;
          } else if (!agreedToTerms) {
            context.showError('Agree to Terms of Service.');
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
