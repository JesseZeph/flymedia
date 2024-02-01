import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_display.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_information.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/contracts_list.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';
import 'package:flymedia_app/utils/modal.dart';
import 'package:flymedia_app/utils/widgets/subscription_info.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class InfluencerMenu extends StatelessWidget {
  const InfluencerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Menu',
                style: appStyle(16, Colors.black, FontWeight.w600),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubscriptionInfo(
                    headerText: 'Account Information',
                    subText:
                        'Provide your account information\nto ensure seemless and timely\npayments',
                    imageUrl: 'assets/images/coins.svg',
                    buttonText: 'Add account',
                    buttonColor: AppColors.mainColor,
                    containerColor: AppColors.cardColor,
                    onTap: () {
                      Get.to(() => const AccountInformation());
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SubscriptionInfo(
                    containerColor: AppColors.cardColor2,
                    headerText: 'Your Contracts',
                    subText:
                        'Access and review ongoing and\ncompleted contracts with influencers',
                    imageUrl: 'assets/images/bro.svg',
                    buttonText: 'View contracts',
                    buttonColor: AppColors.purplePatch,
                    onTap: () {
                      Get.to(() => const InfluencerContracts());
                    },
                  )
                ],
              )),
            ));
  }
}
