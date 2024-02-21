import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/services/database/secure_storage.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/payment_page.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/pin_setup/pin_setup_success.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PinInput extends StatefulWidget {
  const PinInput({super.key, t});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final SecureStore repository = SecureStore();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      textStyle: TextStyle(
          fontSize: 15.sp,
          color: AppColors.mainTextColor,
          fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        color: AppColors.tileColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.mainColor),
      borderRadius: BorderRadius.circular(10.r),
    );

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
              padding: EdgeInsets.only(top: 60.h),
              child: const CustomKarlaText(
                text: 'Set Up Your Pin',
                weight: FontWeight.w700,
                size: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Text(
                'Choose a PIN that you will easily remember to facilitate smooth transfers',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainTextColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
              child: Form(
                key: formKey,
                child: Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  controller: pinController,
                  obscureText: true,
                  useNativeKeyboard: true,
                  onChanged: (_) {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: AnimatedButton(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    repository.storeData(key: 'pin', value: pinController.text);
                    Get.to(() => const PinSetupSuccess());
                  }
                },
                child: const RoundedButtonWidget(
                  title: ' Save Pin',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
