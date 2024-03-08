import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/influencer_add_account.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_display.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/account_information.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/contracts_list.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/points_center.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/modal.dart';
import 'package:flymedia_app/utils/widgets/subscription_info.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class InfluencerMenu extends StatefulWidget {
  const InfluencerMenu({Key? key}) : super(key: key);

  @override
  State<InfluencerMenu> createState() => _InfluencerMenuState();
}

class _InfluencerMenuState extends State<InfluencerMenu> {
  @override
  void initState() {
    super.initState();
    fetchAccountDetails();
  }

  fetchAccountDetails() {
    if (context.read<ProfileProvider>().userProfile == null) {
      return;
    }
    context.read<InfluencerAccountDetailsProvider>().getAccountDetails(
        context.read<ProfileProvider>().userProfile?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    var influencerBankAccount =
        context.watch<InfluencerAccountDetailsProvider>().getAccountResponse;
    var profileIncomplete = context.read<ProfileProvider>().userProfile == null;
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubscriptionInfo(
                        headerText: 'Account Information',
                        subText:
                            'Provide your account information\nto ensure seamless and timely\npayments',
                        imageUrl: 'assets/images/coins.svg',
                        buttonText: 'Get started',
                        buttonColor: AppColors.mainColor,
                        containerColor: AppColors.cardColor,
                        onTap: () {
                          if (profileIncomplete) {
                            context.showError('Please complete profile');
                            return;
                          }
                          Get.to(() => influencerBankAccount != null
                              ? DisplayAccountInfo(
                                  getAccountDetails: influencerBankAccount,
                                )
                              : const AccountInformation());
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
                          if (profileIncomplete) {
                            context.showError('Please complete profile');
                            return;
                          }
                          Get.to(() => InfluencerContracts(
                                userType: 'Influencer',
                                userId: context
                                        .read<ProfileProvider>()
                                        .userProfile
                                        ?.id ??
                                    '',
                              ));
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      SubscriptionInfo(
                        containerColor: AppColors.blueeTint,
                        headerText: 'Earn Points',
                        subText:
                            'Earn points and unlock fun rewards\nas you engage with our platform.',
                        imageUrl: 'assets/images/gift-box.svg',
                        buttonText: 'My points',
                        buttonColor: AppColors.dialogBlue,
                        onTap: () {
                          Get.to(() => const PointsCenter());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
