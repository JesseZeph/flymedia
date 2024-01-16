import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 25.sp,
        ));
  }
}
