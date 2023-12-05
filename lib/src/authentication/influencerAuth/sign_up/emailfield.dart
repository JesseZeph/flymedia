import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

import '../../components/text_input_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController email;
  const EmailField({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    // final emailError = useState<EmailValidationError?>(null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 5.h),
            child: Text(
              'Email address',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.mainTextColor, fontSize: 12.sp),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextInputField(
            controller: email,
            hintText: 'First name and Last name',
            onChanged: (_) {
              // Validate the password and update the error state
              // final emailResult = Email.dirty(value).validator(value);
              // emailError.value = emailResult;
            },
            // errorText: Email.showEmailErrorMessage(emailError.value),
          ),
        ),
      ],
    );
  }
}
