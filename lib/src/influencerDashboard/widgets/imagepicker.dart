import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';

class ProfilePicturePicker extends StatefulWidget {
  const ProfilePicturePicker({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicturePickerState createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
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
              ],
            )
          : Container(
              width: 325.w,
              margin: EdgeInsets.only(top: 15.h, left: 18.h, right: 18.h),
              // padding: EdgeInsets.symmetric(vertical: 40.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Person's icon
                  Container(
                    width: 120.w, // Adjust the size of the container
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightHintTextColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.person_circle,
                      size: 70,
                      color: AppColors.lightHintTextColor.withOpacity(0.4),
                    ),
                  ),
                  // Pen icon container positioned over the person's icon
                  Positioned(
                    right: 128,
                    bottom: 10,
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: AppColors.deepGreen,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.pen,
                        size: 15,
                        color: Colors.white,
                      ),
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
