import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/authentication/components/size_fade.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final void Function(String value) onChanged;
  final String? errorText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final double? width;

  const TextInputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.inputType,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width ?? 325.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: AppColors.lightHintTextColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.r)),
          child: TextFormField(
            onChanged: onChanged,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.lightHintTextColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400)),
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: inputType,
          ),
        ),
        SizeFadeSwitcher(
          child: errorText != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
                  child: Text(
                    errorText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.errorColor),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class NewCustomTextField extends StatelessWidget {
  final String hintText;
  final void Function(String value) onChanged;
  final String? errorText;
  final bool obscureText;
  final TextEditingController? controller;
  const NewCustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 321.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              color: AppColors.lightHintTextColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r)),
          child: TextField(
            onChanged: onChanged,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: AppColors.hintTextColor.withOpacity(0.8),
                ),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.hintTextColor.withOpacity(0.8),
                    fontWeight: FontWeight.w400)),
          ),
        ),
        SizeFadeSwitcher(
          child: errorText != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
                  child: Text(
                    errorText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.errorColor),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
