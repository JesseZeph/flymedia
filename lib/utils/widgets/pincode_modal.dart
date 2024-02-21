import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:pinput/pinput.dart';

import '../../constants/colors.dart';
import '../../src/authentication/components/animated_button.dart';
import '../../src/authentication/components/roundedbutton.dart';
import 'custom_text.dart';

class PinCodeModal extends StatefulWidget {
  const PinCodeModal({super.key});

  @override
  State<PinCodeModal> createState() => _PinCodeModalState();
}

class _PinCodeModalState extends State<PinCodeModal> {
  final TextEditingController pinController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    margin: EdgeInsets.symmetric(horizontal: 15.w),
    textStyle: TextStyle(
        fontSize: 15.sp,
        color: AppColors.mainTextColor,
        fontWeight: FontWeight.w500),
    decoration: BoxDecoration(
      color: AppColors.lightHintTextColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10.r),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const CustomKarlaText(
                text: 'Enter your pin',
                size: 16,
                color: AppColors.mainTextColor,
                weight: FontWeight.w700,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child:
                  // Form(
                  //   key: formKey,
                  //   child:
                  Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: AppColors.mainColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                controller: pinController,
                obscureText: true,
                useNativeKeyboard: true,
                onChanged: (_) {},
              ),
              // ),
            ),
            SizedBox(
              height: 30.h,
            ),
            AnimatedButton(
              onTap: () async {
                var pinCorrect = await repository.verifyPin(pinController.text);

                if (context.mounted) {
                  Navigator.pop(context, pinCorrect);
                }
                // if (formKey.currentState?.validate() ?? false) {
                //   final enteredPin = pinController.text;
                //   final isPinCorrect = await repository.verifyPin(enteredPin);

                //   if (isPinCorrect) {
                //     Get.to(() => const PinSetupSuccess());
                //   } else {
                //     Get.snackbar('Error:', 'Incorrect Pin',
                //         backgroundColor: AppColors.errorColor,
                //         colorText: Colors.white);
                //   }
                // }
              },
              child: const RoundedButtonWidget(
                title: 'Proceed',
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(vertical: 10.w),
            //       child: TextButton(
            //         onPressed: () async {
            //           await repository.clearSecureData();
            //           Get.back();
            //         },
            //         child: const CustomKarlaText(
            //           text: 'Reset Pin',
            //           size: 12,
            //           color: AppColors.mainTextColor,
            //           weight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
