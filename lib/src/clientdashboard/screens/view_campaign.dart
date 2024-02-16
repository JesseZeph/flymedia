import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/campaign_provider.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/src/clientdashboard/screens/preview_listing.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../services/helpers/campaign_helper.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/headings.dart';
import 'applications.dart';

class ViewCampaign extends StatefulWidget {
  final CampaignUploadResponse id;
  final int index;
  const ViewCampaign({super.key, required this.id, required this.index});

  @override
  State<ViewCampaign> createState() => _ViewCampaignState();
}

class _ViewCampaignState extends State<ViewCampaign> {
  late CampaignUploadResponse campaign;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    campaign = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: 'Deleting Campaign'),
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
                if (campaign.assigned == null)
                  TextButton(
                      onPressed: () {
                        Get.to(() => Applications(
                              campaignId: campaign.id,
                              amount: campaign.rate,
                              title: campaign.jobTitle,
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
                          'View Applications',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    heading: 'Minimum Followers required',
                    subText: campaign.minFollowers.toString().formatFigures()),
                Padding(
                  padding: EdgeInsets.all(50.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorColor,
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      await CampaignHelper.deleteCampaign(campaign.id)
                          .then((resp) {
                        if (resp) {
                          context
                              .read<CampaignsNotifier>()
                              .deleteCampaign(widget.index);
                          context.showSuccess('Campaign deleted successfully');
                          Get.back();
                        } else {
                          context.showError('Failed to delete campaign');
                        }
                        setState(() {
                          loading = false;
                        });
                      });
                    },
                    child: Text(
                      'Delete Campaign',
                      style: appStyle(12, Colors.white, FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
