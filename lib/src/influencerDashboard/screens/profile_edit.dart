import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/models/profile/profile_model.dart';
import 'package:flymedia_app/src/influencerDashboard/widgets/imagepicker.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:provider/provider.dart';

import '../../../controllers/profile_provider.dart';
import '../../../route/route.dart';
import '../../../utils/widgets/subheadings.dart';
import '../../authentication/components/text_input_field.dart';
import '../../clientdashboard/screens/widgets/country_dropdown.dart';
import '../../clientdashboard/screens/widgets/custom_text_field.dart';
import '../../clientdashboard/screens/widgets/fly_button.dart';
import '../../clientdashboard/screens/widgets/salary_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.profile});
  final ProfileModel? profile;

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfile> {
  List<String> selectedOptions = [];
  GlobalKey<FormState> formKey = GlobalKey();
  late bool hasFile;

  String? filePath;
  String? averageViews;

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
    setState(() {});
  }

  late TextEditingController fullNameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController locationCtrl;
  late TextEditingController numOfFollowersCtrl;
  late TextEditingController numOfLikesCtrl;
  late TextEditingController profileLinkCtrl;
  late TextEditingController bioCtrl;

  @override
  void initState() {
    super.initState();
    fullNameCtrl =
        TextEditingController(text: widget.profile?.firstAndLastName);
    emailCtrl = TextEditingController(text: widget.profile?.email);
    locationCtrl = TextEditingController(text: widget.profile?.location);
    numOfFollowersCtrl =
        TextEditingController(text: widget.profile?.noOfTikTokFollowers);
    numOfLikesCtrl =
        TextEditingController(text: widget.profile?.noOfTikTokLikes);
    profileLinkCtrl = TextEditingController(text: widget.profile?.profileLink);
    bioCtrl = TextEditingController(text: widget.profile?.bio);
    selectedOptions = widget.profile?.niches ?? [];
    filePath = widget.profile?.imageUrl;
    averageViews = widget.profile?.postsViews;
    hasFile = false;
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    locationCtrl.dispose();
    numOfFollowersCtrl.dispose();
    numOfLikesCtrl.dispose();
    profileLinkCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }

  List<dynamic> isValid() {
    if (formKey.currentState?.validate() ?? false) {
      if (widget.profile == null && averageViews == null) {
        return [false, 'Please choose average views.'];
      } else if (selectedOptions.isEmpty) {
        return [false, 'Add niche options'];
      } else if (filePath == null) {
        return [false, 'Add a photo.'];
      }
    } else {
      return [false, 'One or more fields are empty'];
    }
    return [true, 'Profile complete.'];
  }

  @override
  Widget build(BuildContext context) {
    var isUpdating = context.watch<ProfileProvider>().isFetchingProfile;
    return PopScope(
      canPop: !isUpdating,
      child: Scaffold(
          body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  ProfilePicturePicker(
                    onselect: (path) {
                      filePath = path;
                      hasFile = true;
                    },
                    isEdit: widget.profile != null,
                    imageUrl: filePath,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const SubHeadings(
                      text: 'Your name',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: TextInputField(
                      controller: fullNameCtrl,
                      hintText: 'First and last name',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const SubHeadings(
                      text: 'Email address',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: TextInputField(
                      controller: emailCtrl,
                      hintText: 'sophie@gmail.com',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const SubHeadings(
                      text: 'Location',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: TextInputField(
                      controller: locationCtrl,
                      hintText: 'Singapore',
                      onChanged: (_) {},
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomField(
                            inputType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },
                            textController: numOfFollowersCtrl,
                            text: 'No. of Tiktok Followers'),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomField(
                            inputType: TextInputType.number,
                            textController: numOfLikesCtrl,
                            text: 'No. of Tiktok likes',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const SubHeadings(
                      text: 'Link to TikTok Profile',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: TextInputField(
                        controller: profileLinkCtrl,
                        hintText: 'https://www.tiktok.com/@your username',
                        onChanged: (_) {},
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h, left: 20.w),
                    width: 325.w,
                    child: Text(
                      'Average number of views on your posts',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: DropDowView(
                      initialValue: widget.profile?.postsViews,
                      onSelect: (p0) => averageViews = p0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const SubHeadings(
                      text: 'Niche',
                    ),
                  ),
                  // Display options using Wrap and Chip
                  Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (String selectedOption in selectedOptions)
                          InkWell(
                            onTap: () {
                              toggleOption(selectedOption);
                            },
                            child: Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selectedOption,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(width: 5.w),
                                  const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.mainColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 3.0,
                    runSpacing: 3.0,
                    children: [
                      for (String option in [
                        'Beauty',
                        'Fashion',
                        'Health',
                        'Gaming',
                        'Entertainment',
                        'Lifestyle',
                        'Animals',
                        'Travel',
                        'Family & Parenting',
                        'Sports',
                        'Fitness',
                        'Business & Technology',
                      ])
                        GestureDetector(
                          onTap: () {
                            toggleOption(option);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 10.w),
                            child: Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    option,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.mainColor,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: AppColors.mainColor,
                                    size: 17,
                                  )
                                ],
                              ),
                              backgroundColor: selectedOptions.contains(option)
                                  ? AppColors.mainColor.withOpacity(0.2)
                                  : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.mainColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h, left: 20.w),
                      width: 325.w,
                      child: Text(
                        'Bio',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: CustomInputField(
                        maxLines: 7,
                        maxLength: 1000,
                        hintText:
                            'Write a short and professional bio highlighting your work and skills',
                        onChanged: (_) {},
                        controller: bioCtrl,
                        validate: (val) {
                          if (val == null || val.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: FlyButtons(
                      backText: 'Cancel',
                      onBackButtonPressed: () {
                        if (isUpdating) return;
                        Navigator.pop(context);
                      },
                      submitText: 'Save',
                      onSubmitButtonPressed: () async {
                        if (isUpdating) return;
                        List<dynamic> valid = isValid();
                        if (valid.first) {
                          await context
                              .read<ProfileProvider>()
                              .updateUserProfile(
                                  context.read<LoginNotifier>().userId,
                                  ProfileModel(
                                      id: widget.profile?.id ?? '',
                                      imageUrl: filePath,
                                      firstAndLastName: fullNameCtrl.text,
                                      niches: selectedOptions,
                                      noOfTikTokFollowers:
                                          numOfFollowersCtrl.text,
                                      noOfTikTokLikes: numOfLikesCtrl.text,
                                      location: locationCtrl.text,
                                      postsViews: averageViews,
                                      email: emailCtrl.text,
                                      profileLink: profileLinkCtrl.text,
                                      bio: bioCtrl.text),
                                  hasFile,
                                  widget.profile != null)
                              .then((resp) {
                            if (resp.first) {
                              context.showSuccess(resp.last);
                              navigateToPage(context, '/influencerHomepage');
                            } else {
                              context.showError(resp.last);
                            }
                          });
                        } else {
                          context.showError(valid.last);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUpdating) const AlertLoader(message: 'Updating profile')
        ],
      )),
    );
  }
}
