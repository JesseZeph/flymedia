import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/clientdashboard/screens/verificationinprogress.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/colors.dart';
import '../../authentication/components/animated_button.dart';
import '../../authentication/components/roundedbutton.dart';
import '../../authentication/components/text_input_field.dart';

class ClientVerificationDetails extends HookConsumerWidget {
  const ClientVerificationDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
            child: const HeadingAndSubText(
              heading: 'Company Details',
              subText: "Fill in your company details to be verified.",
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Company name',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextInputField(
                  hintText: 'Enter your company name',
                  onChanged: (_) {},
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Company HQ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextInputField(
                  hintText: 'Where is your company located?',
                  onChanged: (_) {},
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Company website',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextInputField(
                  hintText: 'e.g. https://companyname.com',
                  onChanged: (_) {},
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Company email',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextInputField(
                  hintText: 'Please use your official email address',
                  onChanged: (_) {},
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Contact number of internal member',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextInputField(
                  hintText: 'Who can we get in touch with?',
                  onChanged: (_) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                  left: 25.h,
                ),
                child: AnimatedButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VerificationInProgress()));
                  },
                  child: const RoundedButtonWidget(
                    title: 'Submit',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20.h,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.mainTextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
