import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validators/form_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../components/text_input_field.dart';

class PasswordField extends HookConsumerWidget {
  final TextEditingController passwordController;
  const PasswordField({required this.passwordController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordError = useState<PasswordValidationError?>(null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 5.h),
            child: Text(
              'Password',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.mainTextColor, fontSize: 12.sp),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextInputField(
            controller: passwordController,
            hintText: 'Enter your password',
            obscureText: true,
            onChanged: (value) {
              // Validate the password and update the error state
              final passwordResult = Password.dirty(value).validator(value);
              passwordError.value = passwordResult;
            },
            errorText: Password.showErrorPasswordMessage(passwordError.value),
          ),
        ),
      ],
    );
  }
}
