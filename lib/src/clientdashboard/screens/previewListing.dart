import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/appbar.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/flyButton.dart';
import 'package:flymedia_app/utils/widgets/divider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../route/route.dart';
import '../../../utils/widgets/headings.dart';
// import 'companyDetails.dart';

class PreviewListing extends HookConsumerWidget {
  const PreviewListing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final enteredText = ref.watch(enteredTextProvider.notifier).state;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const FlyAppBar(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.w, bottom: 30.h),
            child: Column(
              children: [
                SizedBox(
                  width: 325.w,
                  child: Text(
                    'Step 3/3',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightMainText.withOpacity(0.9)),
                  ),
                ),
                const Center(
                    child: DashHeadingAndSubText(
                  heading: 'Preview Listing',
                  subText:
                      'Here is a preview of how your campaign will appear to influencers.',
                )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.dialogColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
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
                      'Tiktok Influencer for a Skincare Brand',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      'SkinCeuticals, Singapore',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mainTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    child: Text(
                      '10k - 50k USD',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mainTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: const FullDivider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomPreviewField(
                        icon: Icons.location_on_outlined,
                        text: 'Location',
                        headerText: 'Singapore',
                        iconColor: AppColors.dialogBlue,
                        containerColor: AppColors.dialogBlue.withOpacity(0.2),
                      ),
                      CustomPreviewField(
                        icon: Icons.group,
                        text: 'Engagements Required',
                        headerText: '50,000 - 200,000',
                        iconColor: Colors.orange,
                        containerColor: Colors.orange.withOpacity(0.2),
                      ),
                    ],
                  ),
                  const HeadingAndSubText(
                      heading: 'About Company', subText: AppTexts.dummyText1),
                  const HeadingAndSubText(
                      heading: 'Job Description', subText: AppTexts.dummyText2),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: FlyButtons(
                      backText: 'Cancel',
                      onBackButtonPressed: () {
                        Navigator.pop(context);
                      },
                      submitText: 'Post',
                      onSubmitButtonPressed: () {
                        navigateToPage(context, '/campaignLive');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPreviewField extends StatelessWidget {
  final IconData icon;
  final String text;
  final String headerText;
  final Color? iconColor;
  final Color containerColor;

  const CustomPreviewField({
    super.key,
    required this.text,
    required this.headerText,
    required this.icon,
    required this.iconColor,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(26.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.dialogBlue,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.hintTextColor,
                  fontSize: 12.sp,
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            headerText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.mainTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
