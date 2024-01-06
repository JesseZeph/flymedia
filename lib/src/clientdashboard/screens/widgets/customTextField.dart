import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';
import 'characterCount.dart';

class CustomInputField extends StatelessWidget {
  final int maxLines;
  final int maxLength;
  final String hintText;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validate;

  CustomInputField({
    Key? key,
    this.controller,
    this.maxLines = 1,
    required this.onChanged,
    this.maxLength = 1000,
    required this.hintText,
    this.inputFormatters,
    this.validate, // Change the type to nullable
  }) : super(key: key) {
    // Create a new list with the default formatter
    final defaultFormatters = <TextInputFormatter>[
      Utf8LengthLimitingTextInputFormatter(1000)
    ];

    // Combine the default formatter with any additional formatters
    inputFormat = inputFormatters != null
        ? [...defaultFormatters, ...inputFormatters!]
        : defaultFormatters;
  }

  List<TextInputFormatter> inputFormat = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lightHintTextColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: AppColors.lightHintTextColor.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
        ),
        validator: validate,
      ),
    );
  }
}
