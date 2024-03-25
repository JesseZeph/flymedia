import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/app_constants.dart';
import 'package:flymedia_app/services/helpers/verify_company.dart';
import 'package:flymedia_app/services/validator/validator.dart';
import 'package:flymedia_app/src/clientdashboard/screens/verificationinprogress.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/country_dropdown.dart';
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
  var website = TextEditingController();
  var companyEmail = TextEditingController();
  var memberContact = TextEditingController();

  String? companyHq;
  String? code;

  GlobalKey<FormState> formKey = GlobalKey();

  var loading = false;
  bool isUrlValid = false;

  @override
  void dispose() {
    companyName.dispose();
    website.dispose();
    companyEmail.dispose();
    memberContact.dispose();
    super.dispose();
  }

  bool isValidForm() {
    List<String> fields = [
      companyEmail.text,
      companyName.text,
      website.text,
      memberContact.text
    ];
    return fields.every((field) => field.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                child: const HeadingAndSubText(
                  heading: 'Company Details',
                  subText: "Fill in your company details to be verified.",
                ),
              ),
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
                    if (val == null || val.isEmpty) return '';
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: DropDowView(
                  onSelect: (countries) {
                    companyHq = countries;
                  },
                  items: countriesList,
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
                  hintText: 'e.g. https://www.companyname.com',
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isUrlValid = true;
                      });
                    } else {
                      final isValid = validateURL(value);
                      setState(() {
                        isUrlValid = isValid;
                      });
                    }
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) return '';
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
                  hintText: 'Company official email address',
                  onChanged: (_) {},
                  validator: (val) {
                    if (val == null || val.isEmpty) return '';
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w, bottom: 5.h),
                child: Text(
                  'Company phone contact',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: CountryCode(
                        onSelect: (selectedCode) {
                          code = selectedCode;
                        },
                        items: countryCode,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    TextInputField(
                      width: 240.w,
                      controller: memberContact,
                      inputType: const TextInputType.numberWithOptions(),
                      hintText: 'Company official contact',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) return '';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AnimatedButton(
                    onTap: () async {
                      if (isValidForm()) {
                        setState(() {
                          loading = !loading;
                        });

                        String fullPhoneNumber = '$code${memberContact.text}';

                        VerifyCompanyRequest rawModel = VerifyCompanyRequest(
                            companyName: companyName.text,
                            website: website.text,
                            companyEmail: companyEmail.text,
                            memberContact: fullPhoneNumber,
                            userId: userUid,
                            companyHq: companyHq!);
                        var model = verifyCompanyToJson(rawModel);

                        await VerifyCompanyHelper.verifyCompany(model)
                            .then((result) {
                          setState(() {
                            loading = !loading;
                          });
                          if (result) {
                            Get.offAll(() => const VerificationInProgress());
                          } else {
                            context
                                .showError('Error occured, try again later.');
                          }
                        });
                      } else {
                        context.showError('One or more fields are empty');
                      }
                    },
                    child: const RoundedButtonWidget(
                      title: 'Submit',
                    ),
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.mainTextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
