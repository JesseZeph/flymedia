import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool showTwoButtons = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: AppColors.lightHintTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showTwoButtons
                    ? Icon(
                        CupertinoIcons.delete_simple,
                        color: AppColors.errorColor,
                        size: 35.sp,
                      )
                    : Icon(
                        FluentSystemIcons.ic_fluent_checkmark_circle_regular,
                        color: Colors.green,
                        size: 35.sp,
                      ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              showTwoButtons
                  ? 'This would delete the account details saved on Flymedia. Would you like to proceed?'
                  : "Your account details have been successfully deleted. You can input new account information whenever you are ready to facilitate future payments.",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            showTwoButtons
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.errorColor,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showTwoButtons = false;
                            });
                            // Handle 'Yes' button logic
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            'Delete',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.lightHintTextColor),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: 200.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: AppColors.lightHintTextColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Handle 'Make Payment' button logic
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        'Okay',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
