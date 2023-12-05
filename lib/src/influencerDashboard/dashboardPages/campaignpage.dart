import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/campaign_provider.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../route/route.dart';
import '../../authentication/components/text_input_field.dart';
import '../../clientdashboard/screens/widgets/appbar.dart';
import '../../clientdashboard/screens/widgets/welcomeWidget.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  TextEditingController searchController = TextEditingController();
  List<String> campaignList = ["Tiktok Influencer for a Skincare Brand"];
  List<String> filteredCampaignList = [];

  @override
  void initState() {
    super.initState();
    filteredCampaignList = campaignList;
  }

  void filterCampaignList(String query) {
    setState(() {
      filteredCampaignList = campaignList
          .where((campaign) =>
              campaign.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              subText:
                  "Let’s help you discover the best campaigns that fits your personal brand.",
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: NewCustomTextField(
                controller: searchController,
                hintText: 'Search',
                onChanged: (query) {
                  filteredCampaignList;
                },
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                // navigateToPage(context, '/');
              },
              child: Container(
                width: 321.w,
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.r),
                decoration: const BoxDecoration(
                  color: AppColors.deepGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'Complete your profile now to',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'send applications.',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        TextButton(
                          onPressed: () {
                            navigateToPage(context, '/editProfile');
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Text(
                              'Complete Profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 70.w,
                      height: 70.h,
                      padding: EdgeInsets.all(5.w),
                      child: CircleAvatar(
                        radius: 40.5.w,
                        backgroundColor: AppColors.lightHintTextColor,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/doc.png',
                            fit: BoxFit.cover,
                          ),
                        ),
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
                'Campaign Listing',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mainTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Expanded(
              child: Consumer<CampaignsNotifier>(
                builder: (context, campaignNotifier, child) {
                  campaignNotifier.getCampaigns();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: FutureBuilder<List<CampaignUploadResponse>>(
                      future: campaignNotifier.campaignList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data!.isEmpty) {
                          return const Text('No campaign available');
                        } else {
                          final campaigns = snapshot.data;

                          return ListView.builder(
                              itemCount: campaigns!.length,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var campaign = campaigns[index];
                                return CampaignListTile(
                                  campaign: campaign,
                                );
                              });
                        }
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CampaignListTile extends StatelessWidget {
  final CampaignUploadResponse campaign;
  const CampaignListTile({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          navigateToPage(context, '/viewCampaignListing');
        },
        child: Container(
          width: 321.w,
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.symmetric(
            vertical: 10.w,
          ),
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
        ),
      ),
    );
  }
}
