import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/app_constants.dart';
import 'package:flymedia_app/models/requests/influencerAccount/influencer_account_request.dart';
import 'package:flymedia_app/providers/influencer_add_account.dart';
import 'package:flymedia_app/services/network/api_services.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/text_input_field.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_display.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/rounded_button.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController bankName = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  var loading = false;

  bool isValidForm() {
    List<String> fields = [accountName.text, accountNumber.text, bankName.text];
    return fields.every((field) => field.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: LoadingOverlay(
        isLoading: loading,
        progressIndicator: const AlertLoader(message: 'Adding Account Details'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomKarlaText(
                    text: 'Account name', size: 14.sp, weight: FontWeight.w500),
                SizedBox(height: 10.h),
                TextInputField(
                  controller: accountName,
                  hintText: '',
                  onChanged: (_) {},
                ),
                SizedBox(height: 30.h),
                CustomKarlaText(
                    text: 'Account Number',
                    size: 14.sp,
                    weight: FontWeight.w500),
                SizedBox(height: 10.h),
                TextInputField(
                  controller: accountNumber,
                  hintText: '',
                  onChanged: (_) {},
                ),
                SizedBox(height: 30.h),
                CustomKarlaText(
                    text: 'Receiving bank',
                    size: 14.sp,
                    weight: FontWeight.w500),
                SizedBox(height: 10.h),
                TextInputField(
                  controller: bankName,
                  hintText: '',
                  onChanged: (_) {},
                ),
                SizedBox(height: 30.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                      color: const Color(0XFFFFF2CA),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFFFBA35),
                      ),
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFFFBA35),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomKarlaText(
                          text:
                              'Please double-check your submitted account information carefully. Flymedia will not be held liable for transfers made to an incorrect bank account. Ensuring accuracy is crucial to avoid any payment discrepencies',
                          size: 14.sp,
                          align: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                AnimatedButton(
                  onTap: () async {
                    InfluencerAddAccount? accountDetails;

                    if (isValidForm()) {
                      setState(() {
                        loading = true;
                      });
                      accountDetails = InfluencerAddAccount(
                        influencerId: userUid,
                        accountName: accountName.text,
                        accountNumber: accountNumber.text,
                        bankName: bankName.text,
                      );
                    }

                    bool success = false;

                    if (accountDetails != null) {
                      success = await InfluencerAccountDetailsProvider()
                          .postAccountDetails(accountDetails);
                    }

                    setState(() {
                      loading = false;
                    });

                    if (success) {
                      Get.to(() => const DisplayAccountInfo());
                    } else {
                      context.showError('An error occurred');
                    }
                  },
                  child: const RoundedButtonsWidget(
                    text: 'Save',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
