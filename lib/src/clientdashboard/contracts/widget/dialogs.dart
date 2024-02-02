import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

class ContractDialogWidget extends StatefulWidget {
  const ContractDialogWidget({Key? key, required this.isConfirmAction})
      : super(key: key);
  final bool isConfirmAction;

  @override
  State<ContractDialogWidget> createState() => _ContractDialogWidgetState();
}

class _ContractDialogWidgetState extends State<ContractDialogWidget> {
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
                widget.isConfirmAction
                    ? Icon(
                        CupertinoIcons.question_circle,
                        color: Colors.green,
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
              widget.isConfirmAction
                  ? 'Are you sure you want to proceed and complete your contract? Your action will complete the service agreement'
                  : "Contract completed! We'll now proceed with the payment to the influencer for the successful fulfillment of the contract. Thank you for your collaboration",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            widget.isConfirmAction
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            'Yes',
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
                            Navigator.pop(context, false);
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
                      color: AppColors.mainColor,
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
                        'Done',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: Colors.white,
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
