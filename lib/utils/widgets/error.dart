import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

class ConnectionFaildScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const ConnectionFaildScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   "assets/images/19_Error.png",
          //   fit: BoxFit.cover,
          // ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: 200, // Set the width to 200
              height: 30, // Set the height to 30
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: AppColors.dialogColor,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: AppColors.mainColor, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  onRetry();
                },
                child: Center(
                  child: Text(
                    "retry".toUpperCase(),
                    style:
                        TextStyle(color: AppColors.lightMain, fontSize: 12.sp),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
