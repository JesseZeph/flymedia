import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/campaign_provider.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/src/search/search.dart';
import 'package:flymedia_app/utils/widgets/archery_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../controllers/profile_provider.dart';
import '../../clientdashboard/screens/widgets/appbar.dart';
import '../../clientdashboard/screens/widgets/welcomeWidget.dart';
import '../screens/campaignlisting.dart';
import '../screens/profile_edit.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  bool profileComplete = false;
  @override
  void initState() {
    super.initState();
    checkProfile();
    context.read<CampaignsNotifier>().getCampaigns();
  }

  Future<void> _refreshCampaigns() async {
    await context.read<CampaignsNotifier>().getCampaigns();
  }

  checkProfile() {
    SharedPreferences.getInstance().then((prefs) {
      profileComplete = prefs.getBool('profile') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var loadingProfile = context.watch<ProfileProvider>().isFetchingProfile;
    var userProfile = context.watch<ProfileProvider>().userProfile;
    return EasyRefresh(
      header: const ArcheryHeader(),
      onRefresh: _refreshCampaigns,
      child: Scaffold(
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
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                  child: Container(
                    width: 321.w,
                    height: 45.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: AppColors.lightHintTextColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.search),
                        SizedBox(width: 10.w),
                        const Text('Search')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (!profileComplete)
                GestureDetector(
                  onTap: () {
                    // navigateToPage(context, '/');
                  },
                  child: Container(
                    width: 321.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.r),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    profile: userProfile,
                                  ),
                                ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
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
                    // campaignNotifier.getCampaigns();
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: campaignNotifier.isFetching
                            ? Center(
                                child: Container(
                                  padding: EdgeInsets.all(20.r),
                                  child: const CircularProgressIndicator
                                      .adaptive(),
                                ),
                              )
                            : campaignNotifier.campaignList.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        campaignNotifier.campaignList.length,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var campaign =
                                          campaignNotifier.campaignList[index];
                                      return CampaignListTile(
                                        campaign: campaign,
                                      );
                                    })
                                : const Center(
                                    child: Text('No campaign available'))
                        // FutureBuilder<List<CampaignUploadResponse>>(
                        //   future: campaignNotifier.campaignList,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Center(
                        //         child: SizedBox(
                        //             height: 30.h,
                        //             width: 30.w,
                        //             child:
                        //                 const CircularProgressIndicator.adaptive()),
                        //       );
                        //     } else if (snapshot.hasError) {
                        //       return Text('Error: ${snapshot.error}');
                        //     } else if (snapshot.data!.isEmpty) {
                        //       return const Text('No campaign available');
                        //     } else {
                        //       final campaigns = snapshot.data;

                        //       return ListView.builder(
                        //           itemCount: campaigns!.length,
                        //           scrollDirection: Axis.vertical,
                        //           physics: const AlwaysScrollableScrollPhysics(),
                        //           itemBuilder: (context, index) {
                        //             var campaign = campaigns[index];
                        //             return CampaignListTile(
                        //               campaign: campaign,
                        //             );
                        //           });
                        //     }
                        //   },
                        // ),
                        );
                  },
                ),
              )
            ],
          ),
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
        Get.to(() => ViewCampaignListing(id: campaign));
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
    ));
  }
}
