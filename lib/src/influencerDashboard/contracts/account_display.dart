import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/app_constants.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/get_accountdetails_res.dart';
import 'package:flymedia_app/providers/influencer_add_account.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/delete_dialog.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/rounded_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DisplayAccountInfo extends StatefulWidget {
  const DisplayAccountInfo({
    Key? key,
  }) : super(key: key);

  @override
  _DisplayAccountInfoState createState() => _DisplayAccountInfoState();
}

class _DisplayAccountInfoState extends State<DisplayAccountInfo> {
  late Future<GetAccountResponse> getAccount;

  @override
  void initState() {
    super.initState();
    accountDetails();
  }

  accountDetails() async {
    await getAccountDetails();
    setState(() {
      getAccount = InfluencerAccountDetailsProvider().getAccountResponse;
    });
  }

  // _initData() async {
  //   await getAccountDetails();
  //   setState(() {
  //     getAccount = InfluencerAccountDetailsProvider().getAccountResponse!;
  //   });
  // }

  Future<void> getAccountDetails() async {
    await InfluencerAccountDetailsProvider().getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: FutureBuilder(
          future: getAccount,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final getAccount = snapshot.data!;
              return Column(
                children: [
                  DisplayAccountWidget(
                      heading: 'Account name', subText: getAccount.accountName),
                  SizedBox(height: 30.h),
                  DisplayAccountWidget(
                      heading: 'Receiving bank', subText: getAccount.bankName),
                  SizedBox(height: 30.h),
                  DisplayAccountWidget(
                      heading: 'Account number', subText: getAccount.bankName),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: AnimatedButton(
                      onTap: () {
                        // Handle the 'Edit' button tap
                      },
                      child: const RoundedButtonsWidget(
                        text: 'Edit',
                      ),
                    ),
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
                    ),
                  ),
                ],
              );
            }
          }),
        ));
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

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DeleteDialog();
    },
  );
}
