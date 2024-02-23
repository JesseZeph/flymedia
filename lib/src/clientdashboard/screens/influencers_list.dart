import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/response/get_all_influencers.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/widgets/nichescontainer.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/archery_refresh.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(influencerDetails.firstAndLastName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              padding: EdgeInsets.all(5.w),
              child: CircleAvatar(
                backgroundColor: AppColors.dialogColor,
                radius: 50.w,
                backgroundImage: NetworkImage(influencerDetails.imageUrl),
              ),
            ),

            Text(
              'Bio: ${influencerDetails.bio}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Followers: ${influencerDetails.noOfTikTokFollowers.formatFigures()}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'location: ${influencerDetails.location}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Tiktok Likes: ${influencerDetails.noOfTikTokLikes.formatFigures()}',
              style: const TextStyle(fontSize: 16),
            ),
            Wrap(
                children: influencerDetails.niches
                    .map((niche) => NichesWidget(text: niche.name))
                    .toList()),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
