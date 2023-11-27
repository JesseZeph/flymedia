import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/textstring.dart';
import '../../components/animated_button.dart';
import '../../components/roundedbutton.dart';

class SignUpButton extends HookConsumerWidget {
  final VoidCallback? onTap;
  const SignUpButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedButton(
      onTap: onTap,
      child: const RoundedButtonWidget(
        title: AppTexts.signUp,
      ),
    );
  }
}
