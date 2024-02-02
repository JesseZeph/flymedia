import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

class InfluencerDialogWidget extends StatefulWidget {
  const InfluencerDialogWidget({Key? key, required this.isConfirmAction})
      : super(key: key);
  final bool isConfirmAction;

  @override
  State<InfluencerDialogWidget> createState() => _InfluencerDialogWidgetState();
}

class _InfluencerDialogWidgetState extends State<InfluencerDialogWidget> {
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
                Icon(
                  CupertinoIcons.question_circle,
                  color: Colors.green,
                  size: 35.sp,
                )
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Are you sure you want to proceed and complete your contract? Your action will complete the service agreement',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
          ],
        ),
      ),
    );
  }
}
