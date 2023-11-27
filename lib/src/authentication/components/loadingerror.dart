import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  const ErrorDialog._(
    this.error, {
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
    String errorMessage,
  ) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => ErrorDialog._(errorMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(error),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Okay'),
        )
      ],
    );
  }
}

class LoadingSheet extends StatelessWidget {
  const LoadingSheet._({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(48.r),
        ),
      ),
      context: context,
      builder: (_) => const LoadingSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.mainColor,
          size: 60.r,
        ),
      ),
    );
  }
}
