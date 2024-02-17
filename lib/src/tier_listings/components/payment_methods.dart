import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod(
      {super.key,
      required this.isSelected,
      this.onTap,
      required this.image,
      required this.name});
  final bool isSelected;
  final Function(bool)? onTap;
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      elevation: 0,
      selectedColor: Colors.transparent,
      disabledColor: Colors.transparent,
      checkmarkColor: AppColors.mainColor,
      label: SizedBox(
        width: Get.width.w,
        child: Row(
          children: [
            SizedBox(
              height: 30.h,
              width: 50.w,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SvgPicture.asset(image),
              ),
            ),
            SizedBox(width: 10.w),
            CustomKarlaText(text: name, size: 14, weight: FontWeight.w500)
          ],
        ),
      ),
      selected: isSelected,
      onSelected: onTap,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).r,
          side: BorderSide(
              color: isSelected ? AppColors.mainColor : Colors.grey)),
    );
  }
}
