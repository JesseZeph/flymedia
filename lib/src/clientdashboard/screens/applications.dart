import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../utils/widgets/headings.dart';

class Applications extends StatefulWidget {
  final String campaignId;
  const Applications({super.key, required this.campaignId});

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  late Future<List<ProfileModel>> influencersList;

  @override
  void initState() {
    super.initState();
    influencersList = context
        .read<ApplicationsHelper>()
        .campaignApplicants(campaignId: widget.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16).r,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DashHeadingAndSubText(
                heading: 'Applications',
                subText: 'Send messages to influencers that fit your campaign.',
              ),
              SizedBox(height: 25.h),
              Expanded(
                  child: FutureBuilder<List<ProfileModel>>(
                future: influencersList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const AlertLoader(message: 'Fetching Applicants');
                  } else if (snapshot.hasData &&
                      (snapshot.data?.isNotEmpty ?? false)) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          var influencerProfile = snapshot.data![index];

                          return _ApplicantsTile(influencerProfile);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: snapshot.data?.length ?? 0);
                  }
                  return Center(
                    child: Text(
                      "No applicants for this campaign.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w200,
                            fontSize: 14.sp,
                          ),
                      overflow: TextOverflow.clip,
                    ),
                  );
                },
              ))
            ],
          )),
        ));
  }
}

class _ApplicantsTile extends StatelessWidget {
  final ProfileModel profile;
  const _ApplicantsTile(this.profile);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 10.w, bottom: 15.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppColors.lightHintTextColor.withOpacity(0.2),
          width: 1,
        ))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              padding: EdgeInsets.all(5.w),
              child: CircleAvatar(
                radius: 37.5.w,
                backgroundColor: AppColors.mainColor,
                child: ClipOval(
                  child: Image.network(
                    profile.imageUrl ?? '',
                    width: 75.w,
                    height: 75.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.firstAndLastName ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 5.h),
                Text(
                  '${profile.noOfTikTokFollowers?.formatFigures()} Followers',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightMainText,
                        fontWeight: FontWeight.w200,
                        fontSize: 12.sp,
                      ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
