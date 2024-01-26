import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_page.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class AssignCampaignDialog extends StatefulWidget {
  const AssignCampaignDialog({Key? key}) : super(key: key);

  @override
  State<AssignCampaignDialog> createState() => _AssignCampaignDialogState();
}

class _AssignCampaignDialogState extends State<AssignCampaignDialog> {
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
                    ? CircleAvatar(
                        radius: 35.sp,
                        backgroundColor: AppColors.mainColor,
                        backgroundImage: const AssetImage(
                            'assets/images/sophieEllipse.png'), // Your image asset
                      )
                    : Icon(
                        FluentSystemIcons.ic_fluent_checkmark_circle_regular,
                        color: Colors.green,
                        size: 35.sp,
                      ),
              ],
            ),
            SizedBox(height: 16.h),
            if (showTwoButtons)
              CustomKarlaText(
                text: 'Assign Campaign to Lexy Chang',
                size: 14.sp,
                weight: FontWeight.w700,
              ),
            SizedBox(height: 12.h),
            Text(
              showTwoButtons
                  ? 'Once Assigned, the campaign cannot be reassigned to another person. Are you sure you want to proceed?'
                  : "This campaign has been successfully assigned to Lexy Chang. Please proceed with the payment to begin your contract.",
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
                          color: AppColors.mainColor,
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
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const CampaignPayment());
                        // Handle 'Make Payment' button logic
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        'Make Payment',
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
