import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/app_constants.dart';
import 'package:flymedia_app/services/helpers/verify_company.dart';
import 'package:flymedia_app/src/clientdashboard/screens/verificationinprogress.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../constants/colors.dart';
import '../../../models/requests/verifyCompany/company_verification.dart';
import '../../authentication/components/animated_button.dart';
import '../../authentication/components/roundedbutton.dart';
import '../../authentication/components/text_input_field.dart';

class ClientVerificationDetails extends StatefulWidget {
  const ClientVerificationDetails({super.key});

  @override
  State<ClientVerificationDetails> createState() =>
      _ClientVerificationDetailsState();
}

class _ClientVerificationDetailsState extends State<ClientVerificationDetails> {
  var companyName = TextEditingController();
  var companyHq = TextEditingController();
  var website = TextEditingController();
  var companyEmail = TextEditingController();
  var memberContact = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  var loading = false;

  @override
  void dispose() {
    companyName.dispose();
    companyHq.dispose();
    website.dispose();
    companyEmail.dispose();
    memberContact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                child: HeadingAndSubText(
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
                      controller: companyName,
                      hintText: 'Enter your company name',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '*Required';
                        return null;
                      },
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
                      controller: companyHq,
                      hintText: 'Where is your company located?',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '*Required';
                        return null;
                      },
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
                      controller: website,
                      hintText: 'e.g. https://companyname.com',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '*Required';
                        return null;
                      },
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
                      controller: companyEmail,
                      hintText: 'Please use your official email address',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '*Required';
                        return null;
                      },
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
                      controller: memberContact,
                      inputType: const TextInputType.numberWithOptions(),
                      hintText: 'Who can we get in touch with?',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '*Required';
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.h,
                      left: 25.h,
                    ),
                    child: AnimatedButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = !loading;
                          });
                          VerifyCompanyRequest rawModel = VerifyCompanyRequest(
                              companyName: companyName.text,
                              companyHq: companyHq.text,
                              website: website.text,
                              companyEmail: companyEmail.text,
                              memberContact: memberContact.text,
                              userId: userUid);
                          var model = verifyCompanyToJson(rawModel);

                          await VerifyCompanyHelper.verifyCompany(model)
                              .then((result) {
                            setState(() {
                              loading = !loading;
                            });
                            if (result) {
                              Get.to(() => const VerificationInProgress());
                            } else {
                              context
                                  .showError('Error occured, try again later.');
                              // Get.snackbar('Error', 'Verification request failed');
                            }
                          });
                        } else {
                          formKey.currentState!.reset();
                          context.showError('One or more fields are empty');
                        }
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
                      onPressed: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
          ),
        )),
      ),
    );
  }
}
