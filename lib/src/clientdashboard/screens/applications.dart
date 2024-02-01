import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/src/clientdashboard/client_home_page.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/widget/assign_campaign_dialog.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/extensions/string_extensions.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../utils/widgets/headings.dart';
import '../contracts/payment_page.dart';

class Applications extends StatefulWidget {
  final String campaignId, amount, title;
  const Applications(
      {super.key,
      required this.campaignId,
      required this.amount,
      required this.title});

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
    var loading = context.watch<ApplicationsHelper>().isLoading;
    return LoadingOverlay(
      isLoading: loading,
      progressIndicator: const AlertLoader(message: 'Assigning campaign'),
      child: Scaffold(
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
                  subText:
                      'Send messages to influencers that fit your campaign.',
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

                            return _ApplicantsTile(
                              influencerProfile,
                              widget.title,
                              widget.amount,
                              action: (name, mail) =>
                                  assignInfluencer(name, mail),
                            );
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
          )),
    );
  }

  assignInfluencer(String name, String mail) async {
    context
        .read<ApplicationsHelper>()
        .assignInfluencer(
          campaignId: widget.campaignId,
          name: name,
          mail: mail,
        )
        .then((resp) {
      if (resp.status) {
        context.showSuccess(resp.message);
        Get.offAll(() => const ClientHomePage());
      } else {
        context.showError(resp.message);
      }
    });
  }
}

class _ApplicantsTile extends StatelessWidget {
  final ProfileModel profile;
  final void Function(String, String) action;
  final String title, amount;

  const _ApplicantsTile(this.profile, this.title, this.amount,
      {required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              userProfile: profile,
              isPersonalView: false,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10.w, bottom: 15.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightHintTextColor.withOpacity(0.4),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  padding: EdgeInsets.all(5.w),
                  child: CircleAvatar(
                    radius: 37.5.w,
                    backgroundColor: AppColors.mainColor,
                    backgroundImage: NetworkImage(
                      profile.imageUrl ?? '',
                    ),
                    // child: ClipOval(
                    //   child: Image.network(
                    //     profile.imageUrl ?? '',
                    //     width: 75.w,
                    //     height: 75.w,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
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
            PopupMenuButton<String>(
              elevation: 1,
              offset: const Offset(0, 30),
              icon: const Icon(Icons.more_horiz),
              onSelected: (String value) {
                if (value == 'account_campaign') {
                  _showAccountCampaignDialog(context, amount, title);
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'account_campaign',
                    child: Row(
                      children: [
                        const Icon(Icons.person_add_alt_outlined, size: 18),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text('Assign Campaign'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountCampaignDialog(
      BuildContext context, String amount, String title) async {
    showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AssignCampaignDialog(
          influencerName: profile.firstAndLastName ?? '',
          imageUrl: profile.imageUrl ?? '',
          showTwoBtns: true,
        );
      },
    ).then((assignInfluencer) {
      if (assignInfluencer ?? false) {
        showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return AssignCampaignDialog(
              influencerName: profile.firstAndLastName ?? '',
              imageUrl: profile.imageUrl ?? '',
              showTwoBtns: false,
            );
          },
        ).then((makePayment) async {
          if (makePayment ?? false) {
            bool? paymentSuccessful = await Get.to<bool?>(() => CampaignPayment(
                  imageUrl: profile.imageUrl ?? '',
                  influencerName: profile.firstAndLastName ?? '',
                  amount: amount,
                  title: title,
                ));
            if (paymentSuccessful ?? false) {
              action(profile.firstAndLastName ?? '', profile.email ?? '');
            }
          }
        });
      }
    });
  }
}
