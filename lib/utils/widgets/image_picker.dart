import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';

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
