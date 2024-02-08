import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_display.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/rounded_button.dart';

import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../providers/influencer_add_account.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key, this.account, this.isEdit = false})
      : super(key: key);
  final GetAccountResponse? account;
  final bool isEdit;
  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  late TextEditingController accountName;
  late TextEditingController accountNumber;
  late TextEditingController bankName;
  late GetAccountResponse? userAccount;

  GlobalKey<FormState> formKey = GlobalKey();

  var loading = false;

  addAccount() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        loading = !loading;
      });
      if (widget.isEdit) {
        await context
            .read<InfluencerAccountDetailsProvider>()
            .editAccountDetails(
                id: userAccount?.id ?? '',
                name: accountName.text,
                accountNumber: accountNumber.text,
                bankName: bankName.text);
      } else {
        await context
            .read<InfluencerAccountDetailsProvider>()
            .postAccountDetails(
                id: context.read<ProfileProvider>().userProfile?.id ?? '',
                name: accountName.text,
                accountNumber: accountNumber.text,
                bankName: bankName.text);
      }

      if (context.mounted) {
        userAccount =
            context.read<InfluencerAccountDetailsProvider>().getAccountResponse;
        if (userAccount != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayAccountInfo(getAccountDetails: userAccount!),
              ));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userAccount = widget.account;
    accountName = TextEditingController(text: userAccount?.accountName ?? '');
    accountNumber =
        TextEditingController(text: userAccount?.accountNumber ?? '');
    bankName = TextEditingController(text: userAccount?.bankName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.h,
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
        progressIndicator: const AlertLoader(
          message: 'Adding account',
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomKarlaText(
                    text: 'Account name',
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  _FieldInput(
                    controller: accountName,
                    type: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  // TextInputField(
                  //   controller: accountName,
                  //   hintText: '',
                  //   onChanged: (_) {},
                  // ),
                  SizedBox(height: 30.h),
                  CustomKarlaText(
                    text: 'Account Number',
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  _FieldInput(
                    type: TextInputType.number,
                    controller: accountNumber,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  // TextInputField(
                  //   controller: accountNumber,
                  //   hintText: '',
                  //   onChanged: (_) {},
                  // ),
                  SizedBox(height: 30.h),
                  CustomKarlaText(
                    text: 'Receiving bank',
                    size: 14.sp,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  _FieldInput(
                    controller: bankName,
                    type: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  // TextInputField(
                  //   controller: bankName,
                  //   hintText: '',
                  //   onChanged: (_) {},
                  // ),
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
                      borderRadius: BorderRadius.circular(6.r),
                    ),
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
                                'Please double-check your submitted account information carefully. Flymedia will not be held liable for transfers made to an incorrect bank account. Ensuring accuracy is crucial to avoid any payment discrepancies',
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
                      addAccount();
                    },
                    child: const RoundedButtonsWidget(
                      text: 'Save',
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldInput extends StatelessWidget {
  const _FieldInput(
      {required this.controller, this.validator, required this.type});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 85.h,
        width: 300.w,
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(color: AppColors.mainColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(color: AppColors.mainColor)),
            isDense: true,
            helperText: ' ',
          ),
          validator: validator,
        ));
  }
}
