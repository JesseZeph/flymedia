import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/campaign_provider.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/clientdashboard/screens/previewListing.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../models/response/get_campaign_res.dart';
import '../../../utils/widgets/divider.dart';
import '../../../utils/widgets/headings.dart';
import '../../authentication/components/roundedbutton.dart';

class ViewCampaignListing extends StatefulWidget {
  final String id;
  const ViewCampaignListing({super.key, required this.id});

  @override
  State<ViewCampaignListing> createState() => _ViewCampaignListingState();
}

class _ViewCampaignListingState extends State<ViewCampaignListing> {
  late Future<GetCampaignRes> campaign;
  @override
  void initState() {
    getCampaign();
    super.initState();
  }

  getCampaign() {
    campaign = CampaignHelper.getCampaign(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CampaignsNotifier>(
      builder: (context, campaignNotifier, child) {
        campaignNotifier.getCampaign(widget.id);
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: FutureBuilder<GetCampaignRes>(
              future: campaign,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final campaign = snapshot.data;
                  return Center(
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: CircleAvatar(
                              radius: 37.5.w,
                              backgroundColor: AppColors.mainColor,
                              backgroundImage: NetworkImage(campaign!.imageUrl),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Text(
                            campaign.jobTitle,
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
                            campaign.companyDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
                            '${campaign.rateFrom} - ${campaign.rateTo}',
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
                              containerColor:
                                  AppColors.dialogBlue.withOpacity(0.2),
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
                  );
                }
              },
            ));
      },
    );
  }
}
