import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/src/clientdashboard/client_home_page.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/image_strings.dart';

class VerificationInProgress extends StatefulWidget {
  const VerificationInProgress({super.key, this.shouldValidateCompany = false});
  final bool shouldValidateCompany;

  @override
  State<VerificationInProgress> createState() => _VerificationInProgressState();
}

class _VerificationInProgressState extends State<VerificationInProgress> {
  late bool isValidating;
  @override
  void initState() {
    super.initState();
    savePageAndVerify();
    isValidating = widget.shouldValidateCompany;
  }

  savePageAndVerify() async {
    await SharedPreferences.getInstance().then((prefs) async {
      prefs.setInt('selectedContainer', 4);
      if (widget.shouldValidateCompany) {
        await context
            .read<ApplicationsHelper>()
            .validateCompany(prefs.getString('userId') ?? '')
            .then((isVerified) {
          setState(() {
            isValidating = false;
          });
          if (isVerified) {
            prefs.setInt('selectedContainer', 1);
            Get.offAll(() => const ClientHomePage());
          } else {
            context.showError("Company verification ongoing.");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isValidating,
      progressIndicator: const AlertLoader(message: 'Verifying'),
      child: RefreshIndicator(
        onRefresh: () => savePageAndVerify(),
        backgroundColor: AppColors.mainColor,
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100.h, bottom: 20.h),
                child:
                    Image.asset(AppImages.rafiki, width: 200.w, height: 150.h),
              ),
              Text(
                'Verification In Progress',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainTextColor,
                    ),
              ),
              Container(
                width: 320.w,
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  AppTexts.verifyProgress,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightMainText,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       pushToAndClearStack(context, ClientHomePage());
              //     },
              //     child: Text('Go back to dashboard'))
            ],
          )),
        ),
      ),
    );
  }
}
