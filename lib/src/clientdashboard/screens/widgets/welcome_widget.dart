import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../../constants/colors.dart';

class ClientTopWidget extends StatelessWidget {
  const ClientTopWidget({
    super.key,
    required this.subText,
  });

  final String subText;

  @override
  Widget build(BuildContext context) {
    var name = context.watch<LoginNotifier>().fullName;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            padding: EdgeInsets.all(5.w),
            child: CircleAvatar(
              backgroundColor: AppColors.dialogColor,
              radius: 50.w,
              child: Icon(
                UniconsLine.user,
                color: AppColors.hintTextColor,
                size: 20.w,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${name.split(' ').first},',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  // width: 321,
                  padding: EdgeInsets.only(top: 5.h),

                  child: Text(
                    subText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.lightMainText,
                          fontWeight: FontWeight.w200,
                          fontSize: 12.sp,
                        ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
