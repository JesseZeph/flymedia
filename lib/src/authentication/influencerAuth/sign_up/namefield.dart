import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:form_validators/form_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/text_input_field.dart';

class NameField extends HookConsumerWidget {
  final TextEditingController nameController;

  const NameField({required this.nameController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameError = useState<NameValidationError?>(null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 5.h),
            child: Text(
              'Your name',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.mainTextColor, fontSize: 12.sp),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextInputField(
            controller: nameController,
            hintText: 'First name and Last name',
            onChanged: (value) {
              // Validate the password and update the error state
              final nameResult = Name.dirty(value).validator(value);
              nameError.value = nameResult;
            },
            errorText: Name.showNameErrorMessage(nameError.value),
          ),
        ),
      ],
    );
  }
}
