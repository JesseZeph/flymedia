import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/components/text_input_field.dart';
import 'package:flymedia_app/utils/widgets/divider.dart';
import 'package:form_validators/form_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/textstring.dart';
import '../../../../utils/widgets/headings.dart';
import '../../../clientdashboard/screens/verificationScreen.dart';
import '../../components/loadingerror.dart';
import '../sign_up/social_buttons.dart';
import 'button.dart';
import 'forgot_password.dart';

class SigninWidget extends HookConsumerWidget {
  const SigninWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final passwordError = useState<PasswordValidationError?>(null);
    final emailError = useState<EmailValidationError?>(null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.h, bottom: 32.h),
          child: const HeadingAndSubText(
            heading: AppTexts.welcomeBackHeader,
            subText: AppTexts.welcomeBackSubText,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: EmailFieldLogin(email: email, emailError: emailError),
        ),
        SizedBox(
          height: 25.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextInputField(
            hintText: 'Enter your password',
            obscureText: true,
            controller: password,
            onChanged: (value) {
              // Validate the password and update the error state
              final passwordResult = Password.dirty(value).validator(value);
              passwordError.value = passwordResult;
            },
            // Use the passwordError to display the error text
            errorText: Password.showErrorPasswordMessage(passwordError.value),
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        const DividerWidget(),
        SizedBox(
          height: 25.h,
        ),
        const SocialAuth(),
        SizedBox(
          height: 25.h,
        ),
        Align(
          alignment: Alignment.center,
          child: LoginButton(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ClientVerificationOnboarding()));
            },
          ),
        ),
        SizedBox(height: 10.h),
        const Align(alignment: Alignment.center, child: ForgotPasswordWidget()),
      ],
    );
  }
}

class EmailFieldLogin extends StatelessWidget {
  const EmailFieldLogin({
    super.key,
    required this.email,
    required this.emailError,
  });

  final TextEditingController email;
  final ValueNotifier<EmailValidationError?> emailError;

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      hintText: 'e.g. sophielandon@gmail.com',
      controller: email,
      onChanged: (value) {
        final emailResult = Email.dirty(value).validator(value);
        emailError.value = emailResult;
      },
      errorText: Email.showEmailErrorMessage(emailError.value),
    );
  }
}

//NOTE: GOOD!
void loader(BuildContext context) {
  LoadingSheet.show(context);
}

//TODO: place them in proper files sha
//NOTE: just a simple scaffold for error ui state
extension SnackbarExtension on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(
      message,
      color: Colors.red,
    );
  }

  void showSuccess(String message) {
    _showSnackBar(
      message,
      color: Colors.green,
    );
  }
}
