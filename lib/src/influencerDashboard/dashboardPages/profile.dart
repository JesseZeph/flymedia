import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/profile_edit.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../controllers/login_provider.dart';
import '../../../utils/modal.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/subheadings.dart';
import '../widgets/custom_field.dart';
import '../widgets/nichescontainer.dart';
import '../../../utils/extensions/string_extensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.isPersonalView = true, this.userProfile});
  final bool isPersonalView;
  final ProfileModel? userProfile;

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileModel? profile;
  late bool profileComplete;
  @override
  void initState() {
    super.initState();
    profile = widget.userProfile;
    profileComplete = widget.userProfile != null;
  }

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = context.watch<LoginNotifier>().loggedIn;
    return !isLoggedIn
        ? ModalWidget(context: context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: profileComplete && widget.isPersonalView
                  ? [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile(
                              profile: profile,
                            ),
                          ));
                        },
                        child: Text(
                          'Edit',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColors.mainColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ]
                  : [],
            ),
            body: profileComplete
                ? Center(
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: CircleAvatar(
                              radius: 37.5.w,
                              backgroundColor: AppColors.mainColor,
                              child: ClipOval(
                                child: Image.network(
                                  // 'assets/images/secondOnboard.png',
                                  profile?.imageUrl ?? '',
                                  width: 75.w,
                                  height: 75.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Text(
                            // 'Sophie Light',
                            profile?.firstAndLastName ?? 'Nil',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.mainTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12.h),
                          child: Text(
                            // 'Singapore',
                            profile?.location ?? 'Nil',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.mainTextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        widget.isPersonalView
                            ? Container(
                                margin:
                                    EdgeInsets.only(top: 12.h, bottom: 15.h),
                                child: Text(
                                  // 'https://www.tiktok.com/@sophielight',
                                  profile?.profileLink ?? 'Nil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.dialogBlue,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.message_outlined),
                                    iconSize: 25,
                                    color: AppColors.mainColor,
                                  ),
                                  // Text(
                                  //   'Message Influencer',
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .bodyMedium
                                  //       ?.copyWith(
                                  //         color: AppColors.mainColor,
                                  //         fontSize: 12.sp,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: const FullDivider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomPreview(
                              headerText: profile?.noOfTikTokFollowers
                                      ?.formatFigures() ??
                                  '',
                              text: 'Followers',
                            ),
                            CustomPreview(
                              headerText: profile?.postsViews ?? 'Nil',
                              text: 'Avg Views',
                            ),
                            CustomPreview(
                              headerText:
                                  profile?.noOfTikTokLikes?.formatFigures() ??
                                      '',
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
                            children: profile?.niches
                                    ?.map((niche) => NichesWidget(text: niche))
                                    .toList() ??
                                []),
                        Padding(
                          padding: EdgeInsets.only(top: 14.h),
                          child: const FullDivider(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 22.h),
                          child: InfluencerSubHeading(
                            text: widget.isPersonalView ? 'Your Bio' : 'Bio',
                          ),
                        ),
                        Container(
                          width: 321.w,
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          child: Text(
                            // "Experienced makeup artist and skincare expert with a passion for creating captivating beauty content. My journey is a testament to my dedication, from stunning transformations to in-depth skincare reviews, I've left no beauty stone unturned. Join forces with me to bring your brand to the forefront of beauty on TikTok. Let's collaborate and elevate the world of beauty together.",
                            profile?.bio ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.mainTextColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 321.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 25.h, horizontal: 10.r),
                        decoration: const BoxDecoration(
                          color: AppColors.deepGreen,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                    // navigateToPage(context, '/editProfile');
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        profile: profile,
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
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
                  ),
          );
  }
}
