import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/clientdashboard/clientHomepage.dart';
import 'package:flymedia_app/src/influencerDashboard/influencerHomepage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../accountoption/state.dart';
import '../../components/roundedbutton.dart';
import 'checkemail.dart';

class ResetSuccessful extends HookConsumerWidget {
  const ResetSuccessful({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedContainer = ref.watch(selectedContainerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120.w),
              child: ImageWithTextWidget(
                assetImage: Image.asset(
                  'assets/images/tick.png',
                ),
                headerText: 'Password Changed',
                subText: 'You have successfully reset your password',
              ),
            ),
            GestureDetector(
              onTap: () {
                if (selectedContainer == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ClientHomePage(),
                    ),
                  );
                } else if (selectedContainer == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfluencerHomePage(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const RoundedButtonWidget(
                  title: 'Back to homepage',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
