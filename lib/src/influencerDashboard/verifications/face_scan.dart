import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/custom_text.dart';

class FaceScanPage extends StatefulWidget {
  const FaceScanPage({super.key});

  @override
  State<FaceScanPage> createState() => _FaceScanPageState();
}

class _FaceScanPageState extends State<FaceScanPage> {
  bool isUploadingImage = false;
  File? capturedImage;

  upload(File? image) async {
    capturedImage = image;
    setState(() {
      isUploadingImage = !isUploadingImage;
    });
    var response = await context.read<ProfileProvider>().uploadVerificationInfo(
        image ?? File(''), context.read<LoginNotifier>().userId);
    setState(() {
      isUploadingImage = !isUploadingImage;
    });
    Get.back(result: response.status);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isUploadingImage,
      progressIndicator: const AlertLoader(message: 'Please wait'),
      child: Scaffold(
        body: SafeArea(
            child: isUploadingImage
                ? Column(
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: 40.h,
                      ),
                      Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(capturedImage!))),
                      )
                    ],
                  )
                : SmartFaceCamera(
                    onCapture: (photo) => upload(photo),
                    autoCapture: true,
                    autoDisableCaptureControl: true,
                    defaultCameraLens: CameraLens.front,
                    defaultFlashMode: CameraFlashMode.auto,
                    enableAudio: false,
                    // message: 'Center your face in the circle.',
                    orientation: CameraOrientation.portraitUp,
                    messageBuilder: (context, detectedFace) {
                      if (detectedFace == null) {
                        return _message('Cannot find your face.');
                      }
                      if (!detectedFace.wellPositioned) {
                        return _message('Center your face in the circle');
                      }
                      return const SizedBox.shrink();
                    },
                    showControls: false,
                    indicatorShape: IndicatorShape.circle,
                    // indicatorBuilder: (context, _, __) => Container(
                    //   height: 50.h,
                    //   width: 50.w,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: AppColors.mainColor)),
                    // ),
                  )),
      ),
    );
  }

  Widget _message(String msg) => Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        child: CustomKarlaText(
          text: msg,
          size: 18,
          color: AppColors.mainColor,
        ),
      );
}
