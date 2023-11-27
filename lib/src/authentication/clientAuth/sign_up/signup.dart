// Assuming the state is directly a boolean in checkBoxStateProvider
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/authentication/verification/verifyemailaddress.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/textstring.dart';
import '../../../../providers/provider.dart';
import '../../../../utils/widgets/checkbox.dart';
import '../../../../utils/widgets/divider.dart';
import '../../../../utils/widgets/headings.dart';
import '../../influencerAuth/sign_up/emailfield.dart';
import '../../influencerAuth/sign_up/namefield.dart';
import '../../influencerAuth/sign_up/passwordfield.dart';
import '../../influencerAuth/sign_up/social_buttons.dart';
import 'button.dart';

class SignUp extends HookConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isChecked = ref.watch(checkBoxStateProvider);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.h, bottom: 32.h),
          child: const HeadingAndSubText(
            heading: AppTexts.createAccountHeaderText,
            subText: AppTexts.createAccountSubText,
          ),
        ),
        const SocialAuth(),
        SizedBox(height: 32.h),
        const DividerWidget(),
        SizedBox(height: 25.h),
        NameField(
          nameController: nameController,
        ),
        SizedBox(
          height: 25.h,
        ),
        EmailField(
          emailController: emailController,
        ),
        SizedBox(
          height: 25.h,
        ),
        PasswordField(
          passwordController: passwordController,
        ),
        SizedBox(
          height: 40.h,
        ),
        const CheckWidget(),
        SizedBox(
          height: 15.h,
        ),
        SignUpButton(
          onTap: isChecked
              ? () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VerifyEmailAccount(),
                  ));
                }
              : null,
        ),
      ],
    );
  }
}
