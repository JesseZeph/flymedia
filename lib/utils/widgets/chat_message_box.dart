import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';

class ChatMessageBox extends StatelessWidget {
  const ChatMessageBox(
      {super.key, required this.message, required this.isUserMessage});
  final ChatMessages message;
  final bool isUserMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14).r,
      decoration: BoxDecoration(
        color: isUserMessage ? const Color(0xffF2F4F7) : AppColors.mainColor,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
            topLeft: isUserMessage ? Radius.zero : const Radius.circular(8),
            topRight: isUserMessage ? const Radius.circular(8) : Radius.zero),
      ),
      child: SizedBox(
        width: 200.w,
        child: CustomKarlaText(
          text: message.text ?? '',
          align: TextAlign.start,
          weight: FontWeight.w400,
          color: isUserMessage ? Colors.black : Colors.white,
          size: 14,
        ),
      ),
    );
  }
}
