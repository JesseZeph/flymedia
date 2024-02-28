import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/clientdashboard/screens/preview_listing.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../models/response/campaign_upload_response.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/headings.dart';
import '../../authentication/components/roundedbutton.dart';

class ViewCampaignListing extends StatefulWidget {
  final CampaignUploadResponse id;
  const ViewCampaignListing({super.key, required this.id});

  @override
  State<ViewCampaignListing> createState() => _ViewCampaignListingState();
}

class _ViewCampaignListingState extends State<ViewCampaignListing> {
  late CampaignUploadResponse campaign;
  @override
  void initState() {
    super.initState();
    campaign = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    var isloading = context.watch<ApplicationsHelper>().isLoading;
    var profile = context.watch<ProfileProvider>().userProfile;
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: const AlertLoader(message: 'Sending application'),
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
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
                      backgroundImage: NetworkImage(campaign.imageUrl),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Text(
                    campaign.jobTitle,
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
                    campaign.companyDescription,
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
                    // '${campaign.rateFrom.formatComma()} - ${campaign.rateTo.formatComma()} USD',
                    '${campaign.rate.formatComma()} USD',
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
                      headerText: campaign.country,
                      iconColor: AppColors.dialogBlue,
                      containerColor: AppColors.dialogBlue.withOpacity(0.2),
                    ),
                    CustomPreviewField(
                      icon: Icons.group,
                      text: 'Engagements Required',
                      headerText: campaign.viewsRequired,
                      iconColor: Colors.orange,
                      containerColor: Colors.orange.withOpacity(0.2),
                    ),
                  ],
                ),
                HeadingAndSubText(
                    heading: 'About Company',
                    subText: campaign.companyDescription),
                HeadingAndSubText(
                    heading: 'Job Description',
                    subText: campaign.jobDescription),
                HeadingAndSubText(
                    heading: 'Minimum Followers Required',
                    subText: campaign.minFollowers.toString().formatFigures()),
                Padding(
                    padding: EdgeInsets.all(22.r),
                    child: campaign.checkInfluencerEligibility(
                            int.tryParse(profile?.noOfTikTokFollowers ?? '') ??
                                0)
                        ? AnimatedButton(
                            onTap: () async {
                              if (profile?.isVerified() ?? false) {
                                await context
                                    .read<ApplicationsHelper>()
                                    .applyToCampaign(
                                        userId: profile?.id ?? '',
                                        campaignId: campaign.id)
                                    .then((resp) {
                                  if (resp.first) {
                                    context.showSuccess(resp.last);
                                  } else {
                                    context.showError(resp.last);
                                  }
                                });
                              } else {
                                context.showError(
                                    'You must verify your profile to apply.');
                                return;
                              }
                            },
                            child: const RoundedButtonWidget(
                              title: 'Apply Now',
                            ))
                        : Container(
                            padding: const EdgeInsets.all(10).r,
                            decoration: BoxDecoration(
                                color: AppColors.mainTextColor,
                                borderRadius: BorderRadius.circular(10).r),
                            child: const CustomKarlaText(
                              text:
                                  'You are ineligible to apply for this campaign',
                              color: Colors.white,
                              size: 18,
                              align: TextAlign.center,
                            ),
                          ))
              ],
            ),
          )),
    );
  }
}
