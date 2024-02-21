import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';

import '../../src/clientdashboard/contracts/pin_setup/setup_pin.dart';
import '../widgets/pincode_modal.dart';

mixin PinMixin {
  Future<bool> verifyPin(BuildContext context) async {
    var pinCorrect = await showModalBottomSheet<bool?>(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: const Radius.circular(16).r)),
      context: context,
      builder: (context) => const PinCodeModal(),
    );
    return pinCorrect ?? false;
  }

  Future<void> setupPin(BuildContext context) async {
    var pinIsSet = await Get.to<bool?>(() => const SetupPin()) ?? false;

    if (pinIsSet && context.mounted) {
      context.showSuccess('Pin set successfully, you can now proceed');
    }
  }
}
