import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/pin_setup/pin_input.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class SetupPin extends StatelessWidget {
  const SetupPin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: const CustomKarlaText(
          text: 'Pin Setup',
          size: 16,
          weight: FontWeight.w700,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Image(
              image: const AssetImage('assets/images/pass.png'),
              width: Get.width * 0.5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: const CustomKarlaText(
              text: 'Set Up Your Pin',
              weight: FontWeight.w700,
              size: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Text(
              'Please set up a four-digit PIN before proceeding. This Pin will ensure that only you are authorized to initiate certain actions on your account.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainTextColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: AnimatedButton(
              onTap: () async {
                var pinSet =
                    await Get.to<bool?>(() => const PinInput()) ?? false;
                Get.back(result: pinSet);
              },
              child: const RoundedButtonWidget(
                title: 'Set Pin',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
