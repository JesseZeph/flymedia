import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flymedia_app/src/tier_listings/tier_listings_page.dart';
import 'package:get/get.dart';

class SubscriptionInfo extends StatelessWidget {
  final String headerText;
  final String subText;
  final String imageUrl;
  final String buttonText;
  final Color buttonColor;
  final Color containerColor;
  const SubscriptionInfo(
      {super.key,
      required this.headerText,
      required this.subText,
      required this.imageUrl,
      required this.buttonText,
      required this.buttonColor,
      required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width.w,
        padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.r),
        decoration: BoxDecoration(
            color: containerColor, borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    headerText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    subText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Get.to(() => const TierListingsPage());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: buttonColor),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
