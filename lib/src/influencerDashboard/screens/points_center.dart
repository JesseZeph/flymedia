import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PointsCenter extends StatefulWidget {
  const PointsCenter({super.key});

  @override
  State<PointsCenter> createState() => _PointsCenterState();
}

class _PointsCenterState extends State<PointsCenter> {
  @override
  Widget build(BuildContext context) {
    var points = context.watch<ProfileProvider>().userProfile?.points;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: const CustomKarlaText(
          text: 'Earn Points',
          size: 18,
          weight: FontWeight.w700,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                color: AppColors.lightMain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/amico.svg',
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        const CustomKarlaText(
                          text: 'TOTAL POINTS',
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text.rich(
                          TextSpan(
                              text: '${points?.totalPoints ?? 2} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Points',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600)),
                              ]),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomKarlaText(
                          text: 'Claim 20 points to get a reward',
                          size: 16,
                          weight: FontWeight.w500,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (points?.totalPoints == 20)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 20, bottom: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.2,
                      color: AppColors.lightHintTextColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      const CustomKarlaText(
                        text: 'Claim Your Points',
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      const CustomKarlaText(
                        text:
                            'You have successfully gained 20 points and can now claim your reward',
                        size: 16,
                        height: 2.5,
                        weight: FontWeight.w500,
                        color: AppColors.hintTextColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 15),
                        child: AnimatedButton(
                            onTap: () {},
                            child: const RoundedButtonWidget(
                                title: 'Claim Reward')),
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: const CustomKarlaText(
                text: 'Your points',
                size: 16,
                weight: FontWeight.w700,
                align: TextAlign.left,
              ),
            ),
            const PointsTileWidget(
              imageUrl: 'assets/images/p1.svg',
              firstText: 'Register an account',
              secondText: 'Register your account and get 2 points',
              thirdText: '+2 points',
              icon: CupertinoIcons.checkmark_alt_circle,
              completed: true,
            ),
            PointsTileWidget(
              imageUrl: 'assets/images/p2.svg',
              firstText: 'Complete profile',
              secondText: 'Complete influencer profile and get 2 points',
              thirdText: '+2 points',
              icon: CupertinoIcons.checkmark_alt_circle,
              completed: points?.completedTasks.contains('1') ?? false,
            ),
            PointsTileWidget(
              imageUrl: 'assets/images/p3.svg',
              firstText: 'Complete one campaign',
              secondText: 'Complete one campaign and get 1 point',
              thirdText: '+1 points',
              icon: CupertinoIcons.checkmark_alt_circle,
              completed: points?.completedTasks.contains('2') ?? false,
            ),
            PointsTileWidget(
              imageUrl: 'assets/images/p4.svg',
              firstText: 'Complete five campaigns',
              secondText: 'Complete five campaigns and get 8 points',
              thirdText: '+8 points',
              icon: CupertinoIcons.checkmark_alt_circle,
              completed: points?.completedTasks.contains('3') ?? false,
            ),
          ],
        ),
      ),
    );
  }
}

class PointsTileWidget extends StatelessWidget {
  final String imageUrl;
  final String firstText;
  final String secondText;
  final String thirdText;
  final IconData icon;
  final bool completed;

  const PointsTileWidget({
    Key? key,
    required this.imageUrl,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.icon,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.lightHintTextColor.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomKarlaText(
                  text: firstText,
                  size: 18,
                  weight: FontWeight.w700,
                  align: TextAlign.start,
                ),
                SizedBox(height: 10.h),
                CustomKarlaText(
                  text: secondText,
                  color: AppColors.hintTextColor,
                  size: 14,
                  align: TextAlign.start,
                ),
                SizedBox(height: 10.h),
                CustomKarlaText(
                  text: thirdText,
                  color: AppColors.mainColor,
                  size: 16,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          if (completed)
            Icon(
              icon,
              color: AppColors.greenTick,
            )
        ],
      ),
    );
  }
}
