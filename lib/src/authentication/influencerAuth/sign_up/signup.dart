import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/signup_provider.dart';
import 'package:flymedia_app/models/requests/auth/signup.dart';
import 'package:flymedia_app/src/authentication/clientAuth/sign_in/sign_in_widget.dart';
import 'package:provider/provider.dart';

import '../../../../constants/textstring.dart';
import '../../../../utils/widgets/checkbox.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';
import '../../clientAuth/sign_up/emailfield.dart';
import '../../clientAuth/sign_up/namefield.dart';
import '../../clientAuth/sign_up/passwordfield.dart';
import '../../clientAuth/sign_up/social_buttons.dart';
import 'button.dart';

class InfluencerSignUp extends StatefulWidget {
  const InfluencerSignUp({super.key});

  @override
  State<InfluencerSignUp> createState() => _InfluencerSignUpState();
}

class _InfluencerSignUpState extends State<InfluencerSignUp> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              child: HeadingAndSubText(
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
            ), // Pass the controller here
            SizedBox(
              height: 40.h,
            ),
            const CheckWidget(),
            SizedBox(
              height: 15.h,
            ),
            InfluencerSignUpButton(onTap: () async {
              loader(context);
              signUpNotifier.loader = true;
              SignupModel model = SignupModel(
                  fullname: fullname.text,
                  email: email.text,
                  password: password.text);
              String newModel = signupModelToJson(model);
              await Future.delayed(const Duration(seconds: 1));
              signUpNotifier.influencerSignup(newModel);
            })
          ],
        );
      },
    );
  }
}
