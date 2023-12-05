import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/signup_provider.dart';
import 'package:flymedia_app/models/requests/auth/signup.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_in/sign_in_widget.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/emailfield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/namefield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/passwordfield.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_up/social_buttons.dart';
import 'package:provider/provider.dart';

import '../../../../constants/textstring.dart';
import '../../../../utils/widgets/checkbox.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';
import 'button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.h, bottom: 32.h),
              child: const HeadingAndSubText(
                heading: AppTexts.createAccountHeaderText,
                subText: AppTexts.createAccountSubText,
              ),
            ),
            const SocialAuth(),
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
            const CheckWidget(),
            SizedBox(
              height: 15.h,
            ),
            SignUpButton(onTap: () async {
              loader(context);
              signUpNotifier.loader = true;
              SignupModel model = SignupModel(
                  fullname: fullname.text,
                  email: email.text,
                  password: password.text);
              String newModel = signupModelToJson(model);
              await Future.delayed(const Duration(seconds: 1));
              signUpNotifier.signUp(newModel);
            }),
          ],
        );
      },
    );
  }
}
