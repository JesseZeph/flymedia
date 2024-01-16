import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TierListingsTile extends StatelessWidget {
  const TierListingsTile(
      {super.key,
      required this.boxColor,
      required this.tierName,
      required this.price,
      required this.features,
      required this.textColor});
  final Color boxColor;
  final String tierName;
  final String price;
  final List<String> features;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r, color: boxColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomKarlaText(
            text: tierName,
            size: 12,
            weight: FontWeight.w400,
          ),
          SizedBox(
            height: 10.h,
          ),
          RichText(
              text: TextSpan(
                  text: '\$$price',
                  style: GoogleFonts.karla(
                      color: textColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800),
                  children: [
                TextSpan(
                  text: '/month',
                  style: GoogleFonts.karla(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                )
              ])),
          SizedBox(
            height: 10.h,
          ),
          ...features
              .map((feature) => Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: const Row(
                      children: [Text('')],
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
