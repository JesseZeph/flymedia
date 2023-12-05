import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/src/influencerDashboard/widgets/imagepicker.dart';

import '../../../route/route.dart';
import '../../../utils/widgets/subheadings.dart';
import '../../authentication/components/text_input_field.dart';
import '../../clientdashboard/screens/widgets/country_dropdown.dart';
import '../../clientdashboard/screens/widgets/customTextField.dart';
import '../../clientdashboard/screens/widgets/flyButton.dart';
import '../../clientdashboard/screens/widgets/salaryInput.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfile> {
  List<String> selectedOptions = [];

  void toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const ProfilePicturePicker(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Your name',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: TextInputField(
                hintText: 'First and last name',
                onChanged: (_) {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Email address',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: TextInputField(
                hintText: 'sophie@gmail.com',
                onChanged: (_) {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Location',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: TextInputField(
                hintText: 'Singapore',
                onChanged: (_) {},
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomField(text: 'No. of Tiktok Followers'),
                  SizedBox(
                    width: 20.w,
                  ),
                  const CustomField(text: 'No. of Tiktok likes'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Link to TikTok Profile',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: TextInputField(
                hintText: 'https://www.tiktok.com/@your username',
                onChanged: (_) {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, left: 20.w),
              width: 325.w,
              child: Text(
                'Average number of views on your posts',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: const DropDowView(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: const SubHeadings(
                text: 'Niche',
              ),
            ),
            // Display options using Wrap and Chip
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  for (String selectedOption in selectedOptions)
                    InkWell(
                      onTap: () {
                        toggleOption(selectedOption);
                      },
                      child: Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedOption,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            SizedBox(width: 5.w),
                            const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Wrap(
              spacing: 3.0,
              runSpacing: 3.0,
              children: [
                for (String option in [
                  'Beauty',
                  'Fashion',
                  'Health',
                  'Gaming',
                  'Entertainment',
                  'Lifestyle',
                  'Animals',
                  'Travel',
                  'Family & Parenting',
                  'Sports',
                  'Fitness',
                  'Business & Technology',
                ])
                  GestureDetector(
                    onTap: () {
                      toggleOption(option);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 10.w),
                      child: Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              option,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Icon(
                              Icons.add,
                              color: AppColors.mainColor,
                              size: 17,
                            )
                          ],
                        ),
                        backgroundColor: selectedOptions.contains(option)
                            ? AppColors.mainColor.withOpacity(0.2)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w),
                width: 325.w,
                child: Text(
                  'Bio',
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
                    'Write a short and professional bio highlighting your work and skills',
                onChanged: (_) {},
                controller: TextEditingController(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: FlyButtons(
                backText: 'Cancel',
                onBackButtonPressed: () {
                  Navigator.pop(context);
                },
                submitText: 'Save',
                onSubmitButtonPressed: () {
                  navigateToPage(context, '/influencerHomepage');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
