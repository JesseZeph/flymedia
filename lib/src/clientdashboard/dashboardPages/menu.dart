import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/contracts_list.dart';
import 'package:flymedia_app/src/clientdashboard/screens/influencers_list.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';
import 'package:flymedia_app/utils/widgets/subscription_info.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/login_provider.dart';
import '../../../utils/modal.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

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
                    headerText: 'Influencers',
                    subText: 'See all available influencers for your campaigns',
                    imageUrl: 'assets/images/pricing-plan.svg',
                    buttonText: 'View influencers',
                    buttonColor: AppColors.mainColor,
                    containerColor: AppColors.cardColor,
                    onTap: () {
                      Get.to(() => const AllInfluencersProfile());
                    },
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  SubscriptionInfo(
                    containerColor: AppColors.cardColor2,
                    headerText: 'Your Contracts',
                    subText:
                        'Access and review ongoing and\ncompleted contracts with influencers',
                    imageUrl: 'assets/images/bro.svg',
                    buttonText: 'View contracts',
                    buttonColor: AppColors.purplePatch,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      Get.to(() => Contracts(
                            userType: 'Client',
                            userId: prefs.getString('userId') ?? '',
                          ));
                    },
                  )
                ],
              )),
            ));
  }
}
