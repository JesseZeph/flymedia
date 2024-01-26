import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/src/authentication/components/animated_button.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/widget/dialogs.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';

class ViewCampaignContract extends StatefulWidget {
  const ViewCampaignContract({super.key});

  @override
  State<ViewCampaignContract> createState() => _ViewCampaignContractState();
}

class _ViewCampaignContractState extends State<ViewCampaignContract> {
  late CampaignUploadResponse campaign;
  bool loading = false;
  bool contractCompleted = false;
  DateTime? completionDate;
  @override
  // void initState() {
  //   super.initState();
  //   campaign = widget.id;
  // }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: ''),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Center(
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: CircleAvatar(
                      radius: 37.5.w,
                      backgroundColor: AppColors.mainColor,
                      backgroundImage:
                          const AssetImage('assets/images/sophieEllipse.png'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Text(
                    'Sophie Light',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    'Singapore',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    '\$10,0000',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mainTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: AnimatedButton(
                    onTap: () {
                      if (!contractCompleted) {
                        _showDialog(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(25.r)),
                      child: Text(
                        'Complete Contract',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: const FullDivider(),
                ),
                const CustomHeader(
                    heading: 'Tiktok influencer for a Skincare Brand',
                    subText:
                        "We are looking for a lorem ipsum dolor sit amet consectetur. Aliquam urna duis dignissim enim. Lacus gravida purus orci convallis. Habitant nec cursus a pellentesque pretium ultricies. orem ipsum dolor sit amet consectetur. Aliquam urna duis dignissim enim. Lacus gravida purus orci convallis. Habitant nec cursus a pellentesque pretium ultricies. orem ipsum dolor sit amet consectetur. Aliquam urna duis dignissim enim. Lacus gravida purus orci convallis.")
              ],
            ),
          )),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ContractDialogWidget();
    },
  );
}
