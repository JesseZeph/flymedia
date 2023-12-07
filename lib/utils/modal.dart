import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencerView.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../src/authentication/clientAuth/authenticationview.dart';

class ModalWidget extends StatelessWidget {
  const ModalWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 140.h),
        child: Container(
          width: 270.w,
          // height: 170.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 20,
                blurRadius: 40,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Log In to Continue',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15.h),
              Text(
                'To continue using the Flymedia app, kindly log into your account.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                ),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final userType = prefs.getInt('selectedContainer') ?? 0;

                  if (userType == 1) {
                    // Client
                    Get.to(() => const AuthenticationView());
                  } else if (userType == 2) {
                    // Influencer
                    Get.to(() => const InfluencerAuthView());
                  }
                },
                child: Text('Login',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
