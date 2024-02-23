import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/services/validator/validator.dart';

import '../../components/text_input_field.dart';

class EmailField extends StatefulWidget {
  final TextEditingController email;
  const EmailField({required this.email, super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputField(
                controller: widget.email,
                hintText: 'johndoe@gmail.com',
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isEmailValid = true;
                    });
                  } else {
                    final isValid = validateEmailAddress(value);
                    setState(() {
                      isEmailValid = isValid;
                    });
                  }
                },
              ),
              if (!isEmailValid)
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    'Invalid email address',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
