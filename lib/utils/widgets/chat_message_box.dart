import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';

class ChatMessageBox extends StatefulWidget {
  const ChatMessageBox(
      {super.key, required this.message, required this.isUserMessage});
  final ChatMessages message;
  final bool isUserMessage;

  @override
  State<ChatMessageBox> createState() => _ChatMessageBoxState();
}

class _ChatMessageBoxState extends State<ChatMessageBox> {
  @override
  Widget build(BuildContext context) {
    // var lastUploadTime = context.watch<ChatProvider>().uploadTime;
    // var progress = context.watch<ChatProvider>().uploadProgress;
    return Container(
      padding: const EdgeInsets.all(14).r,
      decoration: BoxDecoration(
        color: widget.isUserMessage
            ? const Color(0xffF2F4F7)
            : AppColors.mainColor,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
            topLeft:
                widget.isUserMessage ? Radius.zero : const Radius.circular(8),
            topRight:
                widget.isUserMessage ? const Radius.circular(8) : Radius.zero),
      ),
      child: SizedBox(
        width: 200.w,
        child: widget.message.isFile
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200.w,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: widget.isUserMessage
                            ? AppColors.mainColor
                            : const Color(0xffF2F4F7),
                        borderRadius: BorderRadius.circular(6).r),
                    child: Row(
                      children: [
                        const Icon(Icons.file_present_outlined),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomKarlaText(
                          text: widget.message.fileName ?? '',
                          align: TextAlign.start,
                          weight: FontWeight.w400,
                          color: Colors.black,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomKarlaText(
                        text: widget.message.text ?? '',
                        align: TextAlign.start,
                        weight: FontWeight.w400,
                        color:
                            widget.isUserMessage ? Colors.black : Colors.white,
                        size: 14,
                      )),
                      // widget.message.justUploaded(lastUploadTime ?? 0) &&
                      //         progress != 0
                      //     ? SizedBox(
                      //         height: 30.h,
                      //         width: 30.w,
                      //         child: CircularProgressIndicator(
                      //           value: progress,
                      //           backgroundColor: AppColors.mainColor,
                      //           color: AppColors.deepGreen,
                      //         ),
                      //       )
                      //     :
                      IconButton(
                        onPressed: () {
                          print(
                              "========> download url: ${widget.message.downloadUrl} =====>");
                        },
                        icon: const Icon(Icons.download_for_offline_outlined),
                        iconSize: 30,
                      )
                    ],
                  )
                ],
              )
            : CustomKarlaText(
                text: widget.message.text ?? '',
                align: TextAlign.start,
                weight: FontWeight.w400,
                color: widget.isUserMessage ? Colors.black : Colors.white,
                size: 14,
              ),
      ),
    );
  }
}
