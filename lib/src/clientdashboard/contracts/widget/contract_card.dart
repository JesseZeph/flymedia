import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/active_campaigns.dart';
import 'package:flymedia_app/providers/campaign_provider.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/view_contract.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ContractCardWidget extends StatefulWidget {
  final ActiveCampaignModel contract;
  final bool isClient;
  const ContractCardWidget({
    super.key,
    required this.contract,
    required this.isClient,
  });

  @override
  State<ContractCardWidget> createState() => _ContractCardWidgetState();
}

class _ContractCardWidgetState extends State<ContractCardWidget> {
  late ActiveCampaignModel activeContract;
  String? selectedOption;
  @override
  void initState() {
    super.initState();
    activeContract = widget.contract;
  }

  acceptOrRejectCampaign(String value) async {
    selectedOption = value;
    setState(() {});
    var update = await context.read<CampaignsNotifier>().acceptOrRejectCampaign(
        accepted: selectedOption ?? '', activeCampaignId: activeContract.id);
    if (update.status) {
      activeContract = activeContract.copyWith(
          status: update.data['status'], message: update.data['message']);
    }
    selectedOption = null;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ViewCampaignContract(
            contract: activeContract,
            isClient: widget.isClient,
          )),
      child: FittedBox(
        child: Container(
          width: Get.width.w,
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.lightMainText.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                activeContract.campaign['jobTitle'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                softWrap: true,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const ShapeDecoration(
                        shape: OvalBorder(), color: AppColors.cardColor2),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${widget.isClient ? activeContract.influencer['firstAndLastName'] : activeContract.campaign['company']['companyName']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const ShapeDecoration(
                        shape: OvalBorder(), color: AppColors.mainColor),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '\$${(activeContract.campaign['rate'] as String).formatComma()}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                width: 130.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: activeContract.btnColor(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomKarlaText(
                  text: activeContract.status,
                  color: Colors.white,
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomKarlaText(
                  text: activeContract.showAcceptButtons() && !widget.isClient
                      ? 'You are yet to accept the campaign'
                      : activeContract.status == 'Rejected' && !widget.isClient
                          ? 'You rejected the campaign'
                          : activeContract.message,
                  size: 12.sp,
                  weight: FontWeight.w500,
                ),
              ),
              if (activeContract.showAcceptButtons() && !widget.isClient)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: Get.width,
                          child: selectedOption == 'Accept'
                              ? Center(
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                )
                              : RoundedButtonWidget(
                                  title: 'Accept',
                                  onTap: () => acceptOrRejectCampaign('Accept'),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: SizedBox(
                            width: Get.width,
                            child: selectedOption == 'Reject'
                                ? Center(
                                    child: SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: () =>
                                        acceptOrRejectCampaign('Reject'),
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.transparent)),
                                    child: Text(
                                      'Reject',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.mainTextColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp),
                                    ),
                                  )),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
