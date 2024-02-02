import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/delete_dialog.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/rounded_button.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../providers/influencer_add_account.dart';
import 'account_information.dart';

class DisplayAccountInfo extends StatefulWidget {
  final GetAccountResponse getAccountDetails;
  const DisplayAccountInfo({
    Key? key,
    required this.getAccountDetails,
  }) : super(key: key);

  @override
  State<DisplayAccountInfo> createState() => _DisplayAccountInfoState();
}

class _DisplayAccountInfoState extends State<DisplayAccountInfo> {
  late GetAccountResponse getAccount;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    getAccount = widget.getAccountDetails;
  }

  deleteAccount() async {
    bool? proceed = await showDialog(
      context: context,
      builder: (context) => const DeleteDialog(isConfirm: true),
    );
    if (proceed ?? false) {
      setState(() {
        isDeleting = !isDeleting;
      });
      if (context.mounted) {
        var deleteResp = await context
            .read<InfluencerAccountDetailsProvider>()
            .deleteAccount('');
        if (deleteResp.status && context.mounted) {
          setState(() {
            isDeleting = !isDeleting;
          });
          showDialog(
            context: context,
            builder: (context) => const DeleteDialog(isConfirm: false),
          ).then((_) => Navigator.pop(context));
          return;
        }
        setState(() {
          isDeleting = !isDeleting;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isDeleting,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () async {
                Get.back();
              },
            ),
            title: const CustomKarlaText(
              text: 'Account Information',
              size: 16,
              weight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              DisplayAccountWidget(
                  heading: 'Account name', subText: getAccount.accountName),
              SizedBox(height: 30.h),
              DisplayAccountWidget(
                  heading: 'Receiving bank', subText: getAccount.bankName),
              SizedBox(height: 30.h),
              DisplayAccountWidget(
                  heading: 'Account number', subText: getAccount.accountNumber),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: AnimatedButton(
                  onTap: () {
                    Get.off(() => AccountInformation(
                          account: getAccount,
                          isEdit: true,
                        ));
                  },
                  child: const RoundedButtonsWidget(
                    text: 'Edit',
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () => deleteAccount(),
                child: CustomKarlaText(
                  text: 'Delete',
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          )),
    );
  }
}

class DisplayAccountWidget extends StatelessWidget {
  final String heading;
  final String subText;
  const DisplayAccountWidget({
    Key? key,
    required this.heading,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      width: Get.width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomKarlaText(
            text: heading,
            size: 14.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 5.h),
          Container(
            width: Get.width.w,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.lightMainText.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(6.w),
            ),
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
