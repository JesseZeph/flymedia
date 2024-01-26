import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/chat_provider.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/models/chats/chat_model.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/chat_page.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/profile_edit.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../providers/login_provider.dart';
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
  ProfileModel? profile;
  ChatModel? chatModel;

  @override
  void initState() {
    super.initState();
    retrieveChat();
  }

  retrieveChat() async {
    if (!widget.isPersonalView) {
      chatModel = await context.read<ChatProvider>().fetchSpecificChat(
          context.read<LoginNotifier>().userId, widget.userProfile?.id ?? '');
    }
  }

  openSocialProfile() async {
    try {
      await launch(
        'https://flutter.dev',
        customTabsOption: const CustomTabsOption(
          toolbarColor: AppColors.mainColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: const SafariViewControllerOption(
          preferredBarTintColor: AppColors.mainColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      context.showError('Could not launch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = context.watch<LoginNotifier>().loggedIn;
    ProfileModel? profile =
        widget.userProfile ?? context.watch<ProfileProvider>().userProfile;

    bool profileComplete = profile != null;
    return !isLoggedIn
        ? ModalWidget(context: context)
        : profileComplete
            ? Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: widget.isPersonalView
                      ? null
                      : IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                  actions: widget.isPersonalView
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
                body: SafeArea(
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 55.r,
                        backgroundImage:
                            NetworkImage(profile.imageUrl ?? '', scale: 1.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        child: Text(
                          // 'Sophie Light',
                          profile.firstAndLastName ?? 'Nil',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          profile.location ?? 'Nil',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      widget.isPersonalView
                          ? IconButton(
                              onPressed: () => openSocialProfile(),
                              icon: const Icon(Icons.tiktok_outlined))
                          // Container(
                          //     margin:
                          //         EdgeInsets.only(top: 12.h, bottom: 15.h),
                          //     child: Text(
                          //       // 'https://www.tiktok.com/@sophielight',
                          //       profile.profileLink ?? 'Nil',
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyMedium
                          //           ?.copyWith(
                          //             color: AppColors.dialogBlue,
                          //             fontSize: 12.sp,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   )
                          : TextButton(
                              onPressed: () async {
                                Get.to(() => ChatPage(
                                      model: chatModel ??
                                          ChatModel(
                                              id: '',
                                              companyOwnerId: context
                                                  .read<LoginNotifier>()
                                                  .userId,
                                              influencerId: profile.toMap(),
                                              lastMessage: '',
                                              newMessagesCount: 0),
                                      isClientView: true,
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(25.r)),
                                child: Text(
                                  'Send Message',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.mainColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              )),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: const FullDivider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomPreview(
                            headerText:
                                profile.noOfTikTokFollowers?.formatFigures() ??
                                    '',
                            text: 'Followers',
                          ),
                          CustomPreview(
                            headerText: profile.postsViews ?? 'Nil',
                            text: 'Avg Views',
                          ),
                          CustomPreview(
                            headerText:
                                profile.noOfTikTokLikes?.formatFigures() ?? '',
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
                          children: profile.niches
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
                          profile.bio ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ))
            : EditProfile(profile: profile);
  }
}
