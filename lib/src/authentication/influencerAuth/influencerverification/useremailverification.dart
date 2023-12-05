import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/colors.dart';
import '../../../../controllers/signup_provider.dart';
import '../../../../models/requests/auth/verification_code.dart';
import '../../components/roundedbutton.dart';
import '../../forgotpassword/screens/checkemail.dart';

class InfluencerEmailVerification extends StatefulWidget {
  const InfluencerEmailVerification({super.key});

  @override
  State<InfluencerEmailVerification> createState() =>
      _UserEmailVerificationState();
}

class _UserEmailVerificationState extends State<InfluencerEmailVerification> {
  final TextEditingController email = TextEditingController();
  final TextEditingController verificationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 45.w,
        height: 45.h,
        margin: EdgeInsets.only(top: 40.w),
        textStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: BoxDecoration(
            color: AppColors.lightHintTextColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r)));

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.mainColor),
      color: AppColors.mainColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(
        10.r,
      ),
    );
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80.h),
                  child: ImageWithTextWidget(
                      assetImage: Image.asset('assets/images/openlaptop.png'),
                      headerText: 'Verify your email address',
                      subText:
                          'Enter the 6 digits OTP sent to your email address'),
                ),
                Align(
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    controller: verificationCode,
                    obscureText: true,
                    length: 6,
                    showCursor: false,
                    onChanged: (_) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Text(
                    "Didn't receive OTP?",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 12.sp),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend OTP",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // signUpNotifier.loader = true;

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String? userEmail = prefs.getString('email');
                    VerificationCode model = VerificationCode(
                        email: userEmail,
                        verificationCode: verificationCode.text);
                    // log(jsonDecode('New Email ' + model.email!));
                    // String newModel = verifyModelToJson(model);
                    signUpNotifier.influencerEmailVerification(model);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: const RoundedButtonWidget(
                      title: 'Verify',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
