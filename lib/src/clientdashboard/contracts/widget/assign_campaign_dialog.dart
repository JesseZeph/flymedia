import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/services/database/secure_storage.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/pin_setup/pin_setup_success.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/pin_setup/setup_pin.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class AssignCampaignDialog extends StatefulWidget {
  const AssignCampaignDialog(
      {Key? key,
      required this.influencerName,
      required this.imageUrl,
      required this.showTwoBtns})
      : super(key: key);
  final String influencerName, imageUrl;
  final bool showTwoBtns;

  @override
  State<AssignCampaignDialog> createState() => _AssignCampaignDialogState();
}

class _AssignCampaignDialogState extends State<AssignCampaignDialog> {
  late bool showTwoButtons;

  final SecureStore repository = SecureStore();

  @override
  void initState() {
    super.initState();
    showTwoButtons = widget.showTwoBtns;
  }

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
                        backgroundImage:
                            NetworkImage(widget.imageUrl), // Your image asset
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
                text: 'Assign Campaign to ${widget.influencerName}',
                size: 14.sp,
                weight: FontWeight.w700,
              ),
            SizedBox(height: 12.h),
            Text(
              showTwoButtons
                  ? 'Once Assigned, the campaign cannot be reassigned to another person. Are you sure you want to proceed?'
                  : "This campaign has been successfully assigned to ${widget.influencerName}. Please proceed with the payment to begin your contract.",
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
                            Navigator.pop(context, true);
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
                      onPressed: () async {
                        if (await repository.isPinSet()) {
                          // PIN is already set, show modal or navigate to PinInput directly
                          showPinInputModal(context);
                        } else {
                          // PIN is not set, navigate to the SetupPin page
                          Get.to(() => const SetupPin());
                        }
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

void showPinInputModal(BuildContext context) {
  final SecureStore repository = SecureStore();
  final formKey = GlobalKey<FormState>();
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
  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.mainColor),
    borderRadius: BorderRadius.circular(10.r),
  );
  Navigator.of(context).pop(); // Close AssignCampaignDialog

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const CustomKarlaText(
                  text: 'Enter Pin',
                  size: 16,
                  color: AppColors.mainTextColor,
                  weight: FontWeight.w700,
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
              AnimatedButton(
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final enteredPin = pinController.text;
                    final isPinCorrect = await repository.verifyPin(enteredPin);

                    if (isPinCorrect) {
                      Get.to(() => const PinSetupSuccess());
                    } else {
                      Get.snackbar('Error:', 'Incorrect Pin',
                          backgroundColor: AppColors.errorColor,
                          colorText: Colors.white);
                    }
                  }
                },
                child: const RoundedButtonWidget(
                  title: ' Save Pin',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: TextButton(
                      onPressed: () async {
                        await repository.clearSecureData();
                        Get.back();
                      },
                      child: const CustomKarlaText(
                        text: 'Reset Pin',
                        size: 12,
                        color: AppColors.mainTextColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
