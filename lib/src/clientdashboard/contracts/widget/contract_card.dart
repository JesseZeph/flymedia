import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/active_campaigns.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/view_contract.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class ContractCardWidget extends StatelessWidget {
  final ActiveCampaignModel contract;
  final bool isClient;
  const ContractCardWidget({
    super.key,
    required this.contract,
    required this.isClient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ViewCampaignContract(
            contract: contract,
            isClient: isClient,
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
                contract.campaign['jobTitle'],
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
                      '${isClient ? contract.influencer['firstAndLastName'] : contract.campaign['company']['companyName']}',
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
                      '\$${(contract.campaign['rateTo'] as String).formatComma()}',
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
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: contract.btnColor(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomKarlaText(
                  text: contract.status,
                  color: Colors.white,
                  size: 14.sp,
                  weight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CustomKarlaText(
                  text: contract.message,
                  size: 12.sp,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
