import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/route/route.dart';
import 'package:flymedia_app/src/accountoption/view.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';

class FlyAppBar extends StatelessWidget {
  const FlyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              // if (value == 'profile') {
              // } else
              if (value == 'logout') {
                _showLogoutDialog(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                // PopupMenuItem<String>(
                //   value: 'profile',
                //   child: ListTile(
                //     leading: const Icon(Icons.person),
                //     title: Text('Profile',
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodySmall
                //             ?.copyWith(fontSize: 12.sp)),
                //   ),
                // ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(
                      'Logout',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DialogWidget();
    },
  );
}

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Dialog(
      shadowColor: AppColors.lightHintTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: AppColors.errorColor,
                  size: 22.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Are you sure you want to logout of the account?',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.errorColor,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: TextButton(
                    onPressed: () {
                      loginNotifier.logout();
                      pushToAndClearStack(context, const AccountOption());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text(
                      'Log Out',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: AppColors.lightHintTextColor),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
