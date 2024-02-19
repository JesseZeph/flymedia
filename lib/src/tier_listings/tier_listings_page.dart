import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/subscription_provider.dart';
import 'package:flymedia_app/src/tier_listings/components/listings_tile.dart';
import 'package:flymedia_app/utils/widgets/custom_back_button.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class TierListingsPage extends StatefulWidget {
  const TierListingsPage({super.key});

  @override
  State<TierListingsPage> createState() => _TierListingsPageState();
}

class _TierListingsPageState extends State<TierListingsPage> {
  @override
  Widget build(BuildContext context) {
    var subLists = context.watch<SubscriptionProvider>().allSubscription;
    var tierLists = context.watch<SubscriptionProvider>().allPlans;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const CustomKarlaText(
          text: 'Choose a plan',
          weight: FontWeight.w700,
          size: 16,
          color: Colors.black,
        ),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
        child: SafeArea(
            child: ListView.separated(
                itemBuilder: (context, index) => TierListingsTile(
                    subscriptionPlan: subLists[index],
                    plan: tierLists[index],
                    textColor: index == 0 ? null : AppColors.lightMain),
                separatorBuilder: (context, index) => SizedBox(height: 40.h),
                itemCount: tierLists.length)),
      ),
    );
  }
}
