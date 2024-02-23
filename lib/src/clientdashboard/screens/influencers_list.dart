import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/get_all_influencers.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/widgets/custom_field.dart';
import 'package:flymedia_app/src/influencerDashboard/widgets/nichescontainer.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/archery_refresh.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:flymedia_app/utils/widgets/divider.dart';
import 'package:flymedia_app/utils/widgets/subheadings.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllInfluencersProfile extends StatefulWidget {
  const AllInfluencersProfile({super.key});

  @override
  State<AllInfluencersProfile> createState() => _AllInfluencersProfileState();
}

class _AllInfluencersProfileState extends State<AllInfluencersProfile> {
  var listController = ScrollController();
  int pageNumber = 2;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileProvider>().getAllInfluencerProfiles(1);
    listController.addListener(loadMore);
  }

  Future<void> _refreshCampaigns() async {
    await context.read<ProfileProvider>().getAllInfluencerProfiles(1);
  }

  loadMore() async {
    if (listController.position.extentAfter < 5 && hasMoreData) {
      hasMoreData = await context
          .read<ProfileProvider>()
          .getAllInfluencerProfiles(pageNumber, isLoadingMore: true);
      if (hasMoreData) {
        pageNumber += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const ArcheryHeader(),
      onRefresh: _refreshCampaigns,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const CustomKarlaText(
            text: 'All Influencers',
            size: 16,
            weight: FontWeight.w700,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Consumer<ProfileProvider>(
                  builder: (context, profileNotifier, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: profileNotifier.isFetching
                          ? Center(
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                child:
                                    const CircularProgressIndicator.adaptive(),
                              ),
                            )
                          : profileNotifier.profileList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: profileNotifier.profileList.length,
                                  scrollDirection: Axis.vertical,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var allInfluencers =
                                        profileNotifier.profileList[index];
                                    return InfluencerProfileList(
                                      allInfluencers: allInfluencers,
                                    );
                                  })
                              : const Center(
                                  child: Text('No Influencer available')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfluencerProfileList extends StatelessWidget {
  final GetAllInfluencersRes allInfluencers;
  const InfluencerProfileList({
    super.key,
    required this.allInfluencers,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: GestureDetector(
      onTap: () {
        Get.to(() => InfluencerDetailsPage(
              influencerDetails: allInfluencers,
            ));
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
                backgroundImage: NetworkImage(allInfluencers.imageUrl),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allInfluencers.firstAndLastName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                ),
                Text(
                  allInfluencers.location,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightMainText,
                        fontWeight: FontWeight.w200,
                        fontSize: 14.sp,
                      ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            allInfluencers.noOfTikTokFollowers.formatFigures(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.greenTick,
                              fontWeight: FontWeight.w700, // Bold
                              fontSize: 14.sp,
                            ),
                      ),
                      TextSpan(
                        text: " Followers",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.lightHintTextColor,
                              fontWeight: FontWeight.w200,
                              fontSize: 12.sp,
                            ),
                      ),
                    ],
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

//testing

class InfluencerDetailsPage extends StatelessWidget {
  final GetAllInfluencersRes influencerDetails;

  const InfluencerDetailsPage({Key? key, required this.influencerDetails})
      : super(key: key);

  openSocialProfile(GetAllInfluencersRes profileC) async {
    var link = Uri.parse(profileC.tikTokLink);
    try {
      if (!await launchUrl(
        link,
        mode: LaunchMode.inAppBrowserView,
      )) {
        throw Exception('Could not launch profile');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          influencerDetails.firstAndLastName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mainTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: CircleAvatar(
              radius: 55.r,
              backgroundImage: NetworkImage(influencerDetails.imageUrl),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 15.h),
          //   child: Text(
          //     // 'Sophie Light',
          //     influencerDetails.firstAndLastName,
          //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //           color: AppColors.mainTextColor,
          //           fontSize: 16.sp,
          //           fontWeight: FontWeight.w600,
          //         ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 12.h),
            child: Text(
              // 'Singapore',
              influencerDetails.location,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mainTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () => openSocialProfile(influencerDetails),
              icon: const Icon(Icons.tiktok_outlined)),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: const FullDivider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomPreview(
                headerText:
                    influencerDetails.noOfTikTokFollowers.formatFigures(),
                text: 'Followers',
              ),
              CustomPreview(
                headerText: influencerDetails.postsViews,
                text: 'Avg Views',
              ),
              CustomPreview(
                headerText: influencerDetails.noOfTikTokLikes.formatFigures(),
                text: 'Likes',
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: const FullDivider(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 22.h),
            child: const InfluencerSubHeading(
              text: 'Niche',
            ),
          ),
          Wrap(
              children: influencerDetails.niches
                  .map((niche) => NichesWidget(text: niche.name))
                  .toList()),
          Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: const FullDivider(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 22.h),
            child: const InfluencerSubHeading(
              text: 'Bio',
            ),
          ),
          Container(
            width: 321.w,
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Text(
              influencerDetails.bio,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mainTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
