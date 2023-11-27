import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/textstring.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/appbar.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/customTextField.dart';
import 'package:flymedia_app/src/clientdashboard/screens/widgets/flyButton.dart';
import 'package:flymedia_app/utils/widgets/headings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';
import '../../../route/route.dart';
import '../../../utils/widgets/subheadings.dart';

final enteredTextProvider = StateProvider<String?>((ref) => null);
final companyDescriptionProvider = StateProvider<String>((ref) => '');
final selectedImageProvider = StateProvider<Uint8List?>((ref) => null);
final companyDescriptionController = TextEditingController();

class CompanyDetails extends HookConsumerWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onChanged: (value) {
                  ref.read(companyDescriptionProvider.notifier).state = value;
                },
                controller: companyDescriptionController,
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
            const FlyImagePicker(),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: FlyButtons(
                onBackButtonPressed: () {
                  navigateToPage(context, '/clientHomePage');
                },
                onSubmitButtonPressed: () {
                  // Call the saveCompanyData method to save data to the database
                  final companyDescription =
                      ref.read(companyDescriptionProvider);
                  ref.read(enteredTextProvider.notifier).state =
                      companyDescription;

                  navigateToPage(context, '/jobSpecification');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlyImagePicker extends StatefulWidget {
  const FlyImagePicker({
    super.key,
  });

  @override
  _FlyImagePickerState createState() => _FlyImagePickerState();
}

class _FlyImagePickerState extends State<FlyImagePicker> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImage();
      },
      child: _image != null
          ? Column(
              children: [
                Container(
                  width: 325.w,
                  margin: EdgeInsets.only(top: 15.h),
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  decoration: BoxDecoration(
                    color: AppColors.dialogColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundImage: MemoryImage(_image!),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.mainColor),
                  ),
                ),
              ],
            )
          : Container(
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
    );
  }
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('IMAGE NOT PICKED');
}
