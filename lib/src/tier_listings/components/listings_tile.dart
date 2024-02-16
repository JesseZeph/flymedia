import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/all_plan_model.dart';
import 'package:flymedia_app/models/subscription_model.dart';
import 'package:flymedia_app/src/tier_listings/tier_features.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TierListingsTile extends StatelessWidget {
  const TierListingsTile({super.key, r, this.subscriptionPlan, this.textColor});
  final AllPlanModel? subscriptionPlan;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => TierFeatures(
            sub: subscriptionPlan!,
          )),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r, color: Colors.blue
            //  subscriptionPlan.bgColor()
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomKarlaText(
              text: subscriptionPlan!.name!,
              size: 14,
              weight: FontWeight.w500,
              color: textColor,
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
                text: TextSpan(
                    text: '\$${subscriptionPlan!.price.toString()}',
                    style: GoogleFonts.karla(
                        color: textColor ?? AppColors.mainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800),
                    children: [
                  TextSpan(
                    text: '/month',
                    style: GoogleFonts.karla(
                        color: textColor ?? AppColors.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  )
                ])),
            SizedBox(
              height: 20.h,
            ),
            CustomKarlaText(
              text: 'description',
              // subscriptionPlan.description,
              size: 14,
              weight: FontWeight.w400,
              color: textColor,
              align: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
