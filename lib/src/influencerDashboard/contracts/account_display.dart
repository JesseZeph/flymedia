import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/delete_dialog.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/rounded_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class DisplayAccountInfo extends StatelessWidget {
  const DisplayAccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomKarlaText(
          text: 'Account Information',
          size: 16.sp,
          weight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: const DisplayAccountWidget(
                heading: 'Account name',
                subText: 'Sophie Light Chan',
              ),
            ),
            SizedBox(height: 30.h),
            const DisplayAccountWidget(
              heading: 'Receiving bank',
              subText: 'United Overseas Bank Limited',
            ),
            SizedBox(height: 30.h),
            const DisplayAccountWidget(
              heading: 'Account number',
              subText: '65526292026',
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22.w,
              ),
              child: AnimatedButton(
                  onTap: () {},
                  child: const RoundedButtonsWidget(
                    text: 'Edit',
                  )),
            ),
            SizedBox(height: 10.h),
            TextButton(
                onPressed: () {
                  _showDialog(context);
                },
                child: CustomKarlaText(
                  text: 'Delete',
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: AppColors.errorColor,
                ))
          ],
        ),
      ),
    );
  }
}

class DisplayAccountWidget extends StatelessWidget {
  final String heading;
  final String subText;
  const DisplayAccountWidget({
    super.key,
    required this.heading,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      width: Get.width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomKarlaText(text: heading, size: 14.sp, weight: FontWeight.w500),
          SizedBox(height: 5.h),
          Container(
            width: Get.width.w,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.lightMainText.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(6.w)),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
            child: CustomKarlaText(
              text: subText,
              size: 16.sp,
              weight: FontWeight.w500,
              align: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DeleteDialog();
    },
  );
}
