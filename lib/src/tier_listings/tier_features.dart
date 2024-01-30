import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymedia_app/models/subscription_model.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/tier_listings/tier_payment.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/widgets/custom_back_button.dart';
import '../../utils/widgets/custom_text.dart';

class TierFeatures extends StatelessWidget {
  const TierFeatures({super.key, required this.sub});
  final Subscriptions sub;
  final Map<String, String> imagePaths = const {
    "basic": "assets/images/basic_tier.svg",
    "pro": "assets/images/pro_tier.svg",
    "premium": "assets/images/premium_tier.svg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const CustomKarlaText(
          text: 'Choose a plan',
          weight: FontWeight.w700,
          size: 16,
          color: Colors.black,
        ),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              width: Get.width.w,
              height: 20.h,
            ),
            SizedBox(
              height: 70.h,
              width: 70.w,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SvgPicture.asset(imagePaths[sub.imagePathKey()] ?? ''),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomKarlaText(
              text: sub.name,
              color: const Color(0xff5f5d5d),
              size: 14,
              weight: FontWeight.w500,
            ),
            SizedBox(
              height: 10.h,
            ),
            RichText(
                text: TextSpan(
                    text: '\$${sub.price}',
                    style: GoogleFonts.karla(
                        color: const Color(0xff0f1521),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800),
                    children: [
                  TextSpan(
                    text: '/month',
                    style: GoogleFonts.karla(
                        color: const Color(0xff0f1521),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  )
                ])),
            SizedBox(
              height: 70.h,
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: CustomKarlaText(
                              align: TextAlign.start,
                              size: 14,
                              weight: FontWeight.w400,
                              text: '\u{2022} ${sub.features[index]}'),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 50.h,
                        ),
                    itemCount: sub.features.length)),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () => Get.to(() => TierPaymentPage(
                  image: imagePaths[sub.imagePathKey()] ?? '',
                  name: sub.name,
                  price: sub.price)),
              child: const RoundedButtonWidget(
                title: 'Choose Plan',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        )),
      ),
    );
  }
}
