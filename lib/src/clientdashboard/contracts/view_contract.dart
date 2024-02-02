// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/active_campaigns.dart';
import 'package:flymedia_app/providers/campaign_provider.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/widget/dialogs.dart';
import 'package:flymedia_app/src/influencerDashboard/contracts/widget/dialogs.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';

class ViewCampaignContract extends StatefulWidget {
  const ViewCampaignContract(
      {super.key, required this.contract, required this.isClient});
  final ActiveCampaignModel contract;
  final bool isClient;

  @override
  State<ViewCampaignContract> createState() => _ViewCampaignContractState();
}

class _ViewCampaignContractState extends State<ViewCampaignContract> {
  late ActiveCampaignModel campaign;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    campaign = widget.contract;
  }

  markCompleted() async {
    showAdaptiveDialog<bool?>(
      context: context,
      builder: (context) => widget.isClient
          ? const ContractDialogWidget(
              isConfirmAction: true,
            )
          : const InfluencerDialogWidget(
              isConfirmAction: true,
            ),
    ).then((proceed) async {
      if (proceed ?? false) {
        setState(() {
          loading = !loading;
        });
        String? userId;
        if (widget.isClient) {
          final prefs = await SharedPreferences.getInstance();
          userId = prefs.getString('userId') ?? '';
        } else {
          userId = context.read<ProfileProvider>().userProfile?.id;
        }
        var response = await context
            .read<CampaignsNotifier>()
            .verifyOrCompleteCampaign(
                userType: widget.isClient ? 'Client' : 'Influencer',
                id: userId ?? '',
                campaignId: campaign.id);
        if (response.status) {
          var updatedCampaign = ActiveCampaignModel.fromMap(response.data);
          campaign = updatedCampaign.copyWith(
              campaign: campaign.campaign,
              client: campaign.client,
              influencer: campaign.influencer);
        }
        setState(() {
          loading = !loading;
        });
        if (widget.isClient) {
          showAdaptiveDialog<bool?>(
              context: context,
              builder: (context) => const ContractDialogWidget(
                    isConfirmAction: false,
                  ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
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
                    padding: EdgeInsets.only(top: 5.h),
                    child: CircleAvatar(
                      radius: 37.5.w,
                      backgroundColor: AppColors.mainColor,
                      backgroundImage: NetworkImage(
                          '${widget.isClient ? campaign.influencer['imageURL'] : campaign.campaign['imageUrl']}'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Text(
                    '${widget.isClient ? campaign.influencer['firstAndLastName'] : campaign.campaign['company']['companyName']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    '${campaign.campaign['country']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    '\$${(campaign.campaign['rateTo'] as String).formatComma()}',
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
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: GestureDetector(
                    onTap: () {
                      if (campaign.checkIfMarkedComplete(widget.isClient)) {
                        context.showSnackBar(campaign.message);
                        return;
                      }
                      markCompleted();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          color: campaign.checkIfMarkedComplete(widget.isClient)
                              ? Colors.grey.shade300
                              : AppColors.mainColor,
                          borderRadius: BorderRadius.circular(25.r)),
                      child: Text(
                        campaign.actionCommand(widget.isClient),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: campaign
                                      .checkIfMarkedComplete(widget.isClient)
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: const FullDivider(),
                ),
                CustomHeader(
                    heading: '${campaign.campaign['jobTitle']}',
                    subText: '${campaign.campaign['jobDescription']}')
              ],
            ),
          )),
    );
  }
}
