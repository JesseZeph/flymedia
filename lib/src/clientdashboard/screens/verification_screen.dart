import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/welcome_widget.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../utils/widgets/tiles.dart';
import '../../authentication/components/roundedbutton.dart';
import 'clientverificationdetails.dart';

class ClientVerificationOnboarding extends StatefulWidget {
  const ClientVerificationOnboarding({Key? key}) : super(key: key);

  @override
  State<ClientVerificationOnboarding> createState() =>
      _ClientVerificationOnboardingState();
}

class _ClientVerificationOnboardingState
    extends State<ClientVerificationOnboarding> {
  @override
  void initState() {
    super.initState();
    context.read<LoginNotifier>().getPref();
    savePage();
  }

  savePage() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedContainer', 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.h),
          const ClientTopWidget(
            subText: 'Welcome to Flymedia!',
          ),
          SizedBox(height: 20.h),
          const HeadingAndSubText(
            heading: AppTexts.verificationHeader,
            subText: AppTexts.verificationSubText,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AnimatedButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ClientVerificationDetails()));
                },
                child: const MiniRoundedButton(
                  title: 'Get verified',
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 23.w),
              child: Text(
                'Why do you need to get verified?',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          const TilesWidget(
            title: 'Verification helps our admins monitor clients effectively',
          ),
          SizedBox(height: 15.h),
          const TilesWidget(
            title: 'It ensures influencers find genuine listings.',
          ),
          SizedBox(height: 15.h),
          const TilesWidget(
            title: 'To show you a legitimate brand',
          ),
          SizedBox(height: 15.h),
          const TilesWidget(
            title: 'Unlock priority access and more as a verified user',
          ),
        ],
      ),
    );
  }
}
