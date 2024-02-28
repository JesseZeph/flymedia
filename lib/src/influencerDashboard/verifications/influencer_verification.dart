import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/components/roundedbutton.dart';
import 'package:flymedia_app/src/influencerDashboard/verifications/face_scan.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';

class InfluencerVerificationPage extends StatelessWidget {
  const InfluencerVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            width: Get.width,
            height: 50.h,
          ),
          const CustomKarlaText(
            text: 'Verify your identity',
            size: 16,
            weight: FontWeight.w700,
          ),
          SizedBox(
            height: 10.h,
          ),
          const CustomKarlaText(
            text: 'We need your selfie to verify your identity.',
            size: 15,
            weight: FontWeight.w500,
            color: Color(0xff5f5d5d),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 148.h,
            width: 148.w,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/verification.png'),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomKarlaText(
                    text: '1.',
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomKarlaText(
                          text: 'Great Lighting.',
                          size: 18,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const CustomKarlaText(
                          text:
                              "Make sure you’re in a well-lit room, with good lighting, to ensure that your shot is easier and accurate.",
                          size: 14,
                          weight: FontWeight.w400,
                          overflow: TextOverflow.clip,
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomKarlaText(
                    text: '2.',
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomKarlaText(
                          text: 'Positioning.',
                          size: 18,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const CustomKarlaText(
                          text:
                              "Hold your device at eye level and maintain a comfortable distance. Ensure your face is centered within the frame and fully visible to the camera.",
                          size: 14,
                          weight: FontWeight.w400,
                          overflow: TextOverflow.clip,
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          InkWell(
            onTap: () async {
              await FaceCamera.initialize();
              var wasSuccessful =
                  await Get.to<bool?>(() => const FaceScanPage());
              if (wasSuccessful ?? false) {
                Get.back(result: true);
              } else {
                if (context.mounted) {
                  context.showError('Verification failed, try again');
                }
              }
            },
            child: const RoundedButtonWidget(title: 'Scan my face'),
          ),
        ],
      )),
    );
  }
}
