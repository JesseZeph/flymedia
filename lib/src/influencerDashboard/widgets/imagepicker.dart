import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';

class ProfilePicturePicker extends StatefulWidget {
  const ProfilePicturePicker({
    Key? key,
    required this.onselect,
    this.isEdit = true,
    this.imageUrl,
  }) : super(key: key);

  final Function(String) onselect;
  final bool isEdit;
  final String? imageUrl;

  @override
  ProfilePicturePickerState createState() => ProfilePicturePickerState();
}

class ProfilePicturePickerState extends State<ProfilePicturePicker> {
  String? _image;
  late bool isEdits;

  void selectImage() async {
    String? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      widget.onselect(img);
      isEdits = false;
      setState(() {
        _image = img;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _image = widget.imageUrl;
    isEdits = widget.isEdit;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImage();
      },
      child: _image != null
          ? SizedBox(
              height: 80.h,
              width: 80.w,
              child: FittedBox(
                fit: BoxFit.contain,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100).r,
                  child: isEdits
                      ? Image.network(
                          _image ?? '',
                          fit: BoxFit.contain,
                        )
                      : Image.file(
                          File(_image ?? ''),
                          fit: BoxFit.contain,
                        ),
                ),
              ))
          : Container(
              width: 325.w,
              margin: EdgeInsets.only(top: 15.h, left: 18.h, right: 18.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Person's icon
                  Container(
                    width: 120.w,
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

Future<String?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file.path;
  }
  return null;
}
