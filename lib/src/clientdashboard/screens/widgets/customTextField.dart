import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import 'characterCount.dart';

class CustomInputField extends ConsumerWidget {
  final int maxLines;
  final int maxLength;
  final String hintText;
  final Function(String) onChanged;
  late final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  CustomInputField({
    Key? key,
    required this.controller,
    this.maxLines = 1,
    required this.onChanged,
    this.maxLength = 1000,
    required this.hintText,
    List<TextInputFormatter>? inputFormatters, // Change the type to nullable
  }) : super(key: key) {
    // Create a new list with the default formatter
    final defaultFormatters = <TextInputFormatter>[
      Utf8LengthLimitingTextInputFormatter(1000)
    ];

    // Combine the default formatter with any additional formatters
    this.inputFormatters = inputFormatters != null
        ? defaultFormatters + inputFormatters
        : defaultFormatters;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: TextField(
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
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
      ),
    );
  }
}
