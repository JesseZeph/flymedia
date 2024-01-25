import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/contracts/contracts_list.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';
import 'package:flymedia_app/src/tier_listings/tier_listings_page.dart';
import 'package:flymedia_app/utils/widgets/subscription_info.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

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
                    headerText: 'Get Premium',
                    subText:
                        'Explore our pricing plans tailored\nto suit your needs',
                    imageUrl: 'assets/images/pricing-plan.svg',
                    buttonText: 'Subscribe now',
                    buttonColor: AppColors.mainColor,
                    containerColor: AppColors.cardColor,
                    onTap: () {
                      Get.to(() => const TierListingsPage());
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SubscriptionInfo(
                    containerColor: AppColors.cardColor2,
                    headerText: 'Your contacts',
                    subText:
                        'Access and review ongoing and\ncompleted contracts with influencers',
                    imageUrl: 'assets/images/bro.svg',
                    buttonText: 'View contracts',
                    buttonColor: AppColors.purplePatch,
                    onTap: () {
                      Get.to(() => const Contracts());
                    },
                  )
                ],
              )),
            ));
  }
}
