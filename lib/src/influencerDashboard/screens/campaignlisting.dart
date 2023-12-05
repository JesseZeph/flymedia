import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/clientdashboard/screens/previewListing.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/textstring.dart';
import '../../../controllers/login_provider.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/headings.dart';
import '../../authentication/components/roundedbutton.dart';

class ViewCampaignListing extends StatelessWidget {
  const ViewCampaignListing({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);

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
            Padding(
              padding: EdgeInsets.all(22.r),
              child: AnimatedButton(
                  onTap: () {},
                  child: const RoundedButtonWidget(
                    title: 'Apply Now',
                  )),
            )
          ],
        ),
      ),
    );
  }
}
