import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/src/clientdashboard/screens/companyDetails.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/campaign_provider.dart';
import '../screens/view_campaign.dart';
import '../screens/widgets/appbar.dart';
import '../screens/widgets/welcomeWidget.dart';

class Campaign extends StatefulWidget {
  const Campaign({super.key});

  @override
  State<Campaign> createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CampaignsNotifier>(
      builder: (context, campaignNotifier, child) {
        campaignNotifier.getCampaigns();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: const FlyAppBar(),
          ),
          backgroundColor: AppColors.lightHintTextColor.withOpacity(0.02),
          body: Center(
            child: Column(
              children: [
                const ClientTopWidget(
                  subText: "Let's find the best talent for you.",
                ),
                SizedBox(height: 40.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const CompanyDetails());
                  },
                  child: Container(
                    width: 321.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.r),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color:
                                AppColors.lightHintTextColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Container(
                          width: 30.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.r, horizontal: 2.r),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor.withOpacity(0.2)),
                          child: const Icon(
                            FluentSystemIcons.ic_fluent_add_filled,
                            color: AppColors.mainColor,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Post a campaign',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 321.w,
                  margin: EdgeInsets.only(top: 20.h),
                  child: Text(
                    'Posted Campaigns',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<CampaignUploadResponse>>(
                    future: campaignNotifier.campaignList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data!.isEmpty) {
                        return const Text('No Campaign Available');
                      } else {
                        final campaigns = snapshot.data;
                        return ListView.builder(
                            itemCount: campaigns!.length,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var campaign = campaigns[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: ClientCampaignListing(
                                  campaign: campaign,
                                ),
                              );
                            });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClientCampaignListing extends StatelessWidget {
  final CampaignUploadResponse campaign;
  const ClientCampaignListing({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
          onTap: () {
            Get.to(() => ViewCampaign(
                  id: campaign.id,
                ));
          },
          child: Container(
            width: 321.w,
            margin: EdgeInsets.only(top: 15.h),
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  padding: EdgeInsets.all(5.w),
                  child: CircleAvatar(
                    backgroundColor: AppColors.dialogColor,
                    radius: 50.w,
                    backgroundImage: NetworkImage(campaign.imageUrl),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.jobTitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                    ),
                    Text(
                      campaign.companyDescription,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.lightMainText,
                            fontWeight: FontWeight.w200,
                            fontSize: 12.sp,
                          ),
                    ),
                    Text(
                      campaign.country,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.lightMainText,
                            fontWeight: FontWeight.w200,
                            fontSize: 12.sp,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
