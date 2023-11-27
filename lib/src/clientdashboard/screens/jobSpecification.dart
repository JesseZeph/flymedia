import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/appbar.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/country_dropdown.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/customTextField.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/flyButton.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/salaryInput.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../utils/widgets/subheadings.dart';
import '../../authentication/components/text_input_field.dart';

class JobSpecification extends HookConsumerWidget {
  JobSpecification({super.key});
  final selectedSalaryRangeProvider = StateProvider<String>((ref) => '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedSalaryRange = ref.watch(selectedSalaryRangeProvider);
    //
    // void handleRangeSelection(String range) {
    //   ref.read(selectedSalaryRangeProvider.notifier).state = range;
    // }

    // List<String> rangeOptions = [
    //   '10,000 - 50,000',
    //   '50,000 - 200,000',
    //   '200,000 - 500,000',
    //   '500,000 - 1,000,000',
    //   '1,000,000 - 3,000,000',
    // ];

    // List<Widget> gridTiles = rangeOptions.map((range) {
    //   return GestureDetector(
    //     onTap: () {
    //       handleRangeSelection(range);
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: range == selectedSalaryRange
    //             ? AppColors.mainColor
    //             : AppColors.dialogColor,
    //         borderRadius: BorderRadius.circular(20.r),
    //       ),
    //       child: Center(
    //         child: Text(
    //           range,
    //           style: TextStyle(
    //             color:
    //                 range == selectedSalaryRange ? Colors.white : Colors.black,
    //             fontSize: 9.sp,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const FlyAppBar(),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.w),
              width: 325.w,
              child: Text(
                'Step 2/3',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.lightMainText.withOpacity(0.9)),
              ),
            ),
            const DashHeadingAndSubText(
              heading: 'Job Specifications',
              subText: 'Give more information about this campaign.',
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
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: const CHeadingAndSubText(
            //     heading: 'Is this role open worldwide?',
            //     subText:
            //         "Selecting 'Yes' means that the influencer can work anywhere regardless of their location and time zone.",
            //   ),
            // ),

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

            // Container(
            //   width: 325.w,
            //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3, // Number of columns
            //       childAspectRatio: 3.0,
            //       crossAxisSpacing: 10.0,
            //       mainAxisSpacing: 10.0,
            //       // Adjust this value to control row spacing
            //     ),
            //     shrinkWrap: true,
            //     physics:
            //         const NeverScrollableScrollPhysics(), // Disable scrolling
            //     itemCount: gridTiles.length,
            //     itemBuilder: (context, index) {
            //       return gridTiles[index];
            //     },
            //   ),
            // ),
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
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: FlyButtons(
                onBackButtonPressed: () {
                  Navigator.pop(context);
                },
                onSubmitButtonPressed: () {
                  navigateToPage(context, '/previewListing');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
