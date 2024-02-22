import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/signup_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../components/text_input_field.dart';

class PasswordField extends StatefulWidget {
  final String? text;
  final TextEditingController password;
  const PasswordField({required this.password, super.key, this.text});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    // final passwordError = useState<PasswordValidationError?>(null);
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 5.w, bottom: 5.h),
              child: Text(
                widget.text ?? 'Password',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.mainTextColor, fontSize: 12.sp),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextInputField(
              controller: widget.password,
              hintText: '*******',
              obscureText: signupNotifier.obscureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  signupNotifier.obscureText = !signupNotifier.obscureText;
                },
                child: Icon(
                  signupNotifier.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.hintTextColor,
                ),
              ),
              onChanged: (_) {
                // Validate the password and update the error state
                // final passwordResult = Password.dirty(value).validator(value);
                // passwordError.value = passwordResult;
              },
              // errorText: Password.showErrorPasswordMessage(passwordError.value),
            ),
          ),
        ],
      );
    });
  }
}
