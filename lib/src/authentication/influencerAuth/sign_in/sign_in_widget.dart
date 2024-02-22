import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/models/requests/auth/influencer_login_model.dart';
import 'package:flymedia_app/src/authentication/components/text_input_field.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/divider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/textstring.dart';
import '../../../../utils/widgets/headings.dart';
import '../../../influencerDashboard/influencer_homepage.dart';
import '../../components/loadingerror.dart';
import '../influencerverification/useremailverification.dart';
import '../sign_up/social_buttons.dart';
import 'button.dart';
import 'forgot_password.dart';

class InfluencerSignIn extends StatefulWidget {
  const InfluencerSignIn({super.key});

  @override
  State<InfluencerSignIn> createState() => _InfluencerSignInState();
}

class _InfluencerSignInState extends State<InfluencerSignIn> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios_new)),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 32.h),
              child: const HeadingAndSubText(
                heading: AppTexts.welcomeBackHeader,
                subText: AppTexts.welcomeBackSubText,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: EmailFieldLogin(email: email),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextInputField(
                hintText: 'Enter your password',
                obscureText: loginNotifier.obscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    loginNotifier.obscureText = !loginNotifier.obscureText;
                  },
                  child: Icon(loginNotifier.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                controller: password,
                onChanged: (value) {
                  // Validate the password and update the error state
                  // final passwordResult = Password.dirty(value).validator(value);
                  // passwordError.value = passwordResult;
                },
                // Use the passwordError to display the error text
                // errorText: Password.showErrorPasswordMessage(passwordError.value),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            const DividerWidget(),
            SizedBox(
              height: 25.h,
            ),
            const SocialAuth(
              isSignUp: false,
              userIsClient: false,
            ),
            SizedBox(
              height: 25.h,
            ),
            Align(
              alignment: Alignment.center,
              child: InfluencerLoginButton(
                onTap: () async {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    context.showError('One or more fields are empty.');
                    return;
                  }

                  InfluencerLoginModel model = InfluencerLoginModel(
                      email: email.text,
                      password: password.text,
                      userType: "Influencer");
                  String newModel = influencerLoginModelToJson(model);
                  await loginNotifier
                      .influencerSignin(newModel)
                      .then((success) async {
                    if (success.first) {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('email', email.text);
                      Get.offAll(() => success.last
                          ? const InfluencerHomePage()
                          : const InfluencerEmailVerification());
                    } else {
                      context.showError(success.last);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 10.h),
            const Align(
                alignment: Alignment.center, child: ForgotPasswordWidget()),
          ],
        );
      },
    );
  }
}

class EmailFieldLogin extends StatelessWidget {
  const EmailFieldLogin({
    super.key,
    required this.email,
    // required this.emailError,
  });

  final TextEditingController email;
  // final ValueNotifier<EmailValidationError?> emailError;

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      hintText: 'e.g. sophielandon@gmail.com',
      controller: email,
      onChanged: (value) {
        // final emailResult = Email.dirty(value).validator(value);
        // emailError.value = emailResult;
      },
      // errorText: Email.showEmailErrorMessage(emailError.value),
    );
  }
}

//NOTE: GOOD!
void loader(BuildContext context) {
  LoadingSheet.show(context);
}
