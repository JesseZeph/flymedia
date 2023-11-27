import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/src/clientdashboard/screens/previewListing.dart';

import '../../../constants/colors.dart';
import '../../../constants/textstring.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/headings.dart';

class ViewCampaign extends StatelessWidget {
  const ViewCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
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
            SizedBox(height: 15.h),
            TextButton(
                onPressed: () {
                  navigateToPage(context, '/applications');
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
                    'View Applications',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          ],
        ),
      ),
    );
  }
}
