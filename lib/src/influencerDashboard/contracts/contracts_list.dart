import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/view_contract.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/widget/contract_card.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/view_contract.dart';
import 'package:get/get.dart';

class InfluencerContracts extends StatefulWidget {
  const InfluencerContracts({super.key});

  @override
  State<InfluencerContracts> createState() => _InfluencerContractsState();
}

class _InfluencerContractsState extends State<InfluencerContracts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Your Contracts',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                ContractCardWidget(
                  heading: 'Tiktok Influencer for a Skincare Brand',
                  amount: '\$10,000',
                  name: 'Facebook',
                  buttonText: 'In Progress',
                  buttonColor: Colors.green,
                  status: 'This listing has not been completed',
                  onTap: () {
                    Get.to(() => const InfluencerCampaignContract());
                  },
                ),
                SizedBox(height: 30.h),
                ContractCardWidget(
                  heading: 'Looking for a Content Creator for a Food Brand',
                  amount: '\$10,000',
                  name: 'Hao Foods',
                  buttonText: 'Completed',
                  buttonColor: AppColors.green,
                  status: 'This listing has been completed',
                  onTap: () {
                    Get.to(() => const InfluencerCampaignContract());
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
