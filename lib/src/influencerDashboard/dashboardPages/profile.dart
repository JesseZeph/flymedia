import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../controllers/login_provider.dart';
import '../../../controllers/profile_provider.dart';
import '../../../utils/modal.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/subheadings.dart';
import '../widgets/custom_field.dart';
import '../widgets/nichescontainer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = context.watch<LoginNotifier>().loggedIn;
    var profileComplete = context.watch<ProfileProvider>().userProfile != null;
    return !isLoggedIn
        ? ModalWidget(context: context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(Icons.arrow_back_ios),
              // ),
              actions: profileComplete
                  ? [
                      TextButton(
                        onPressed: () {
                          navigateToPage(context, '/editProfile');
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
            body: !profileComplete
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        // navigateToPage(context, '/');
                      },
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
                                    navigateToPage(context, '/editProfile');
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
                  )
                : Center(
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: CircleAvatar(
                              radius: 37.5.w,
                              backgroundColor: AppColors.mainColor,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/secondOnboard.png',
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
                            'Sophie Light',
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
                            ' Singapore',
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
                        Container(
                          margin: EdgeInsets.only(top: 12.h),
                          child: Text(
                            'https://www.tiktok.com/@sophielight',
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
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: const FullDivider(),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomPreview(
                              headerText: '401.7k',
                              text: 'Followers',
                            ),
                            CustomPreview(
                              headerText: '600k',
                              text: 'Avg No. of Views',
                            ),
                            CustomPreview(
                              headerText: '27.1m',
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
                        const Row(
                          children: [
                            NichesWidget(text: 'Beauty'),
                            NichesWidget(text: 'Business & Fashion'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14.h),
                          child: const FullDivider(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 22.h),
                          child: const InfluencerSubHeading(
                            text: 'Your Bio',
                          ),
                        ),
                        Container(
                          width: 321.w,
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          child: Text(
                            "Experienced makeup artist and skincare expert with a passion for creating captivating beauty content. My journey is a testament to my dedication, from stunning transformations to in-depth skincare reviews, I've left no beauty stone unturned. Join forces with me to bring your brand to the forefront of beauty on TikTok. Let's collaborate and elevate the world of beauty together.",
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
                  ),
          );
  }
}
