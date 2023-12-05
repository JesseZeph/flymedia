import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/src/authentication/clientAuth/authenticationview.dart';
import 'package:flymedia_app/src/authentication/influencerAuth/influencerView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/widgets/headings.dart';

class AccountOption extends StatefulWidget {
  const AccountOption({Key? key}) : super(key: key);

  @override
  _AccountOptionState createState() => _AccountOptionState();
}

class _AccountOptionState extends State<AccountOption> {
  int selectedContainer = 0;

  @override
  Widget build(BuildContext context) {
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
                buildContainer(
                  context,
                  icon: FontAwesomeIcons.briefcase,
                  label: "I'm a Client",
                  value: 1,
                ),
                SizedBox(height: 20.h),
                buildContainer(
                  context,
                  icon: Icons.person_2_rounded,
                  label: "I'm an Influencer",
                  value: 2,
                ),
                SizedBox(height: 60.h),
                if (isButtonVisible()) buildButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(BuildContext context,
      {required IconData icon, required String label, required int value}) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      decoration: BoxDecoration(
        color: selectedContainer == value
            ? AppColors.lightMain
            : Colors.white.withOpacity(0.5),
        border: Border.all(
          color: selectedContainer == value
              ? AppColors.mainColor
              : AppColors.lightHintTextColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: RadioListTile(
        activeColor: AppColors.mainColor,
        dense: true,
        value: value,
        groupValue: selectedContainer,
        onChanged: (newValue) {
          setState(() {
            selectedContainer = newValue as int;
          });
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 17.r,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.mainTextColor.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Column(
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
          onPressed: isButtonEnabled()
              ? () {
                  // Navigate to the appropriate authentication view based on the selected container
                  if (selectedContainer == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthenticationView(),
                      ),
                    );
                  } else if (selectedContainer == 2) {
                    print('Influencer');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InfluencerAuthView(),
                      ),
                    );
                  }
                }
              : null,
          child: Text(
            getButtonText(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  builder: (context) => const AuthenticationView(),
                ),
              );
            } else if (selectedContainer == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const InfluencerAuthView(),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool isButtonVisible() {
    // Add your logic for when to show the button
    return true;
  }

  bool isButtonEnabled() {
    // Add your logic for when the button should be enabled
    return true;
  }

  String getButtonText() {
    // Customize button text based on the selected container
    if (selectedContainer == 1) {
      return "Join as Client";
    } else if (selectedContainer == 2) {
      return "Join as Influencer";
    } else {
      return "Join";
    }
  }
}
