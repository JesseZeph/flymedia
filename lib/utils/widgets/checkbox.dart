// CheckWidget.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/colors.dart';
import '../../providers/provider.dart';

class CheckWidget extends HookConsumerWidget {
  const CheckWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkBoxStateProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            ref.read(checkBoxStateProvider.notifier).toggle();
          },
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: isChecked
                ? Icon(
                    Icons.check,
                    size: 13.r,
                    color: AppColors.mainColor,
                  )
                : null,
          ),
        ),
        SizedBox(width: 10.w),
        Text.rich(
          TextSpan(
            text: "Yes, I agree to Flymedia's ",
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
            children: [
              TextSpan(
                text: 'Terms of Services',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11, color: AppColors.mainColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("Tap gesture");
                  },
              ),
              TextSpan(
                text: " and ",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11, color: AppColors.mainColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("Tap gesture");
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
