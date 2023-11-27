import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/src/accountoption/state.dart';
import 'package:flymedia_app/src/authentication/clientAuth/authenticationview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/widgets/headings.dart';
import '../authentication/influencerAuth/influencerView.dart';

class AccountOption extends ConsumerWidget {
  const AccountOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedContainer = ref.watch(selectedContainerProvider);
    final buttonText = ref.watch(buttonTextProvider);
    final isButtonVisible = ref.watch(buttonVisibleProvider);

    final isButtonEnabled = selectedContainer != null && buttonText != '';

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300.w,
              margin: EdgeInsets.only(top: 50.h, bottom: 20.h),
              child: const HeadingAndSubText(
                heading: AppTexts.pathText,
                subText: AppTexts.pathSubText,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300.w,
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(
                    color: selectedContainer == 1
                        ? AppColors.lightMain
                        : Colors.white.withOpacity(0.5),
                    border: Border.all(
                      color: selectedContainer == 1
                          ? AppColors.mainColor
                          : AppColors.lightHintTextColor.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: RadioListTile(
                    activeColor: AppColors.mainColor,
                    dense: true,
                    value: 1,
                    groupValue: selectedContainer,
                    onChanged: (value) => ref
                        .read(selectedContainerProvider.notifier)
                        .state = value,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.briefcase,
                          size: 17.r,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "I'm a Client",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.mainTextColor.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 300.w,
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(
                    color: selectedContainer == 2
                        ? AppColors.lightMain
                        : Colors.white.withOpacity(0.5),
                    border: Border.all(
                        width: 1,
                        color: selectedContainer == 2
                            ? AppColors.mainColor
                            : AppColors.lightHintTextColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: RadioListTile(
                    activeColor: AppColors.mainColor,
                    dense: true,
                    value: 2,
                    groupValue: selectedContainer,
                    onChanged: (value) => ref
                        .read(selectedContainerProvider.notifier)
                        .state = value,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          size: 17.r,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "I'm an Influencer",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14.sp,
                                  color:
                                      AppColors.mainTextColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(height: 60.h),
                if (isButtonVisible)
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300.w, 45.h),
                          backgroundColor: AppColors.mainColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        onPressed: isButtonEnabled
                            ? () {
                                // Navigate to the appropriate authentication view based on the selected container
                                if (selectedContainer == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthenticationView()));
                                } else if (selectedContainer == 2) {
                                  print('Influencer');
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const InfluencerAuthView()));
                                }
                              }
                            : null,
                        child: Text(
                          buttonText,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.dialogColor,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            if (selectedContainer == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthenticationView(),
                                ),
                              );
                            } else if (selectedContainer == 2) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InfluencerAuthView(),
                                ),
                              );
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                                text: 'Do you have an account?   ',
                                style: Theme.of(context).textTheme.bodySmall,
                                children: [
                                  TextSpan(
                                    text: 'Log In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.mainColor),
                                  )
                                ]),
                          ))
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
