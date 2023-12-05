import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/src/clientdashboard/screens/previewListing.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/appbar.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/country_dropdown.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/customTextField.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/flyButton.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/salaryInput.dart';
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
    setState(() {
      if (pickedFile != null) pickedFile.readAsBytes();
    });
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
                  'Step 1/3',
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
                child: Column(
                  children: [
                    const Icon(
                      FontAwesomeIcons.images,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Upload Photo',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                controller: TextEditingController(),
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
                  const CustomField(text: 'From'),
                  SizedBox(
                    width: 45.w,
                  ),
                  const CustomField(text: 'To'),
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
              child: const DropDowView(),
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
                controller: TextEditingController(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: FlyButtons(
                onBackButtonPressed: () {
                  navigateToPage(context, '/clientHomePage');
                },
                onSubmitButtonPressed: () {
                  Get.to(() => const PreviewListing());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
