import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/models/requests/campaign/campain_upload.dart';
import 'package:flymedia_app/src/clientdashboard/screens/previewListing.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/appbar.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/country_dropdown.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/customTextField.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/flyButton.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/salaryInput.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';
import '../../../route/route.dart';
import '../../../utils/widgets/subheadings.dart';
import '../../authentication/components/text_input_field.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({super.key});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      hasPickedFile = true;
      filePath = pickedFile.path;
    }
    setState(() {});
    // setState(() {
    //   if (pickedFile != null) pickedFile.readAsBytes();
    // });
  }

  TextEditingController companyDescriptionCtrl = TextEditingController();
  TextEditingController jobTitleCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController rateFromCtrl = TextEditingController();
  TextEditingController rateToCtrl = TextEditingController();
  TextEditingController jobDescriptionCtrl = TextEditingController();

  String? viewsRequired;
  String? filePath;
  bool hasPickedFile = false;

  @override
  void dispose() {
    companyDescriptionCtrl.dispose();
    jobTitleCtrl.dispose();
    rateFromCtrl.dispose();
    rateToCtrl.dispose();
    jobDescriptionCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  List<Object> validateFields() {
    if (filePath == null) {
      return [false, 'Please upload an image'];
    } else if (viewsRequired == null) {
      return [false, 'Please add views requirement'];
    } else if (companyDescriptionCtrl.text.isEmpty ||
        jobDescriptionCtrl.text.isEmpty ||
        jobTitleCtrl.text.isEmpty ||
        rateFromCtrl.text.isEmpty ||
        rateToCtrl.text.isEmpty ||
        countryCtrl.text.isEmpty) {
      return [false, 'One or more fields are empty!'];
    }
    return [true, 'Form is valid'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h), child: const FlyAppBar()),
      body: Center(
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(left: 18.w),
                width: 325.w,
                child: Text(
                  'Step 1/2',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.lightMainText.withOpacity(0.9)),
                )),
            const DashHeadingAndSubText(
              heading: AppTexts.companyDetailsHeader,
              subText: AppTexts.companyDetailsSubText,
            ),
            Container(
              margin: EdgeInsets.only(left: 18.w),
              child: const Headings(
                text: 'Company description',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 18.w, right: 18.w),
              child: CustomInputField(
                controller: companyDescriptionCtrl,
                maxLines: 5,
                maxLength: 500,
                hintText:
                    'Tell us a bit about your company that will show influencers what your company is about',
                onChanged: (_) {},
              ),
            ),
            SizedBox(
              height: 25.w,
            ),
            const DashHeadingAndSubText(
              heading: 'Company Logo',
              subText:
                  'Your company logo will appear at the top of your listing and your Flymedia profile',
            ),
            GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 15.h, left: 18.h, right: 18.h),
                padding: EdgeInsets.symmetric(vertical: 40.w),
                decoration: BoxDecoration(
                  color: AppColors.dialogColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: hasPickedFile
                    ? SizedBox(
                        height: 50.h,
                        width: 50.h,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.file(File(filePath ?? '')),
                        ),
                      )
                    : Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.images,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Upload Photo',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ],
                      ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Job Title',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomInputField(
                maxLines: 2,
                hintText:
                    'e.g Influencer for a Skincare brand, UGC Creator for a Shoe collection.',
                onChanged: (value) {},
                controller: jobTitleCtrl,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Country',
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: TextInputField(
                  hintText: 'Singapore',
                  onChanged: (_) {},
                  controller: countryCtrl,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: const CHeadingAndSubText(
                heading: 'Payment rate',
                subText:
                    "Let interested applicants know how much you are willing to pay for this listing",
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                      inputType: TextInputType.number,
                      textController: rateFromCtrl,
                      text: 'From'),
                  SizedBox(
                    width: 45.w,
                  ),
                  CustomField(
                      inputType: TextInputType.number,
                      textController: rateToCtrl,
                      text: 'To'),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h, left: 20.w),
                width: 325.w,
                child: Text(
                  'Number of views required',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: DropDowView(
                onSelect: (views) {
                  viewsRequired = views;
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w),
                width: 325.w,
                child: Text(
                  'Job description',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomInputField(
                maxLines: 7,
                maxLength: 1000,
                hintText:
                    'Give clear expectations about your campaign listing and the deliverables required',
                onChanged: (_) {},
                controller: jobDescriptionCtrl,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: FlyButtons(
                onBackButtonPressed: () {
                  navigateToPage(context, '/clientHomePage');
                },
                onSubmitButtonPressed: () {
                  List<Object> validForm = validateFields();

                  if (validForm.first as bool) {
                    CampaignUploadRequest request = CampaignUploadRequest(
                        imageUrl: filePath ?? '',
                        companyDescription: companyDescriptionCtrl.text,
                        jobTitle: jobTitleCtrl.text,
                        country: countryCtrl.text,
                        rateFrom: rateFromCtrl.text,
                        rateTo: rateToCtrl.text,
                        viewsRequired: viewsRequired ?? 'Nil',
                        jobDescription: jobDescriptionCtrl.text);

                    Get.to(() => PreviewListing(
                          campaignDetails: request,
                        ));
                  } else {
                    context.showSnackBar(validForm.last as String);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
