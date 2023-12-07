import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, this.onTap, required this.controller});
  final void Function()? onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 45.h,
      padding: EdgeInsets.only(bottom: 5.w),
      color: AppColors.lightHintTextColor.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 30.h,
                  color: AppColors.mainTextColor,
                ),
              ),
              FittedBox(
                child: Container(
                  padding: EdgeInsets.only(top: 10.h, left: 0),
                  width: 310.w,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search campaign',
                        hintStyle: appStyle(
                            18, AppColors.hintTextColor, FontWeight.w500),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.5)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.5)),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                                color: AppColors.lightHintTextColor,
                                width: 0.5)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.5)),
                        border: InputBorder.none),
                    controller: controller,
                    cursorHeight: 25,
                    style:
                        appStyle(14, AppColors.hintTextColor, FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          FittedBox(
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.search_circle_outline,
                  size: 25.h,
                  color: AppColors.hintTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle appStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw);
}

class NoSearchResults extends StatelessWidget {
  const NoSearchResults({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/optimized_search.png"),
            const SizedBox(width: 20),
            ReusableText(
                text: text,
                style: appStyle(18, AppColors.mainTextColor, FontWeight.w500))
          ],
        ));
  }
}

class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
