import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/controllers/chat_provider.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/models/chats/chat_model.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/utils/widgets/chat_message_box.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.model, required this.isClientView});
  final ChatModel model;
  final bool isClientView;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var textController = TextEditingController();
  bool showSend = false;
  late ScrollController listController;
  String? finalMessage;
  late Query<ChatMessages> chats;
  bool pickEmoji = false;
  String? clientId;
  String? influencerId;
  bool hasPickedFile = false;
  File? filePicked;
  ChatModel? msgSent;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
    clientId = widget.isClientView
        ? widget.model.companyOwnerId
        : widget.model.companyOwnerId['_id'];
    influencerId = widget.isClientView
        ? widget.model.influencerId['_id']
        : widget.model.influencerId;
    chats = context
        .read<ChatProvider>()
        .chatStream(clientId: clientId, influencerId: influencerId);
  }

  void sendMessage() async {
    ChatMessages msg = ChatMessages(
      clientId: clientId ?? '',
      influencerId: influencerId ?? '',
      type: hasPickedFile ? 'File' : 'Text',
      text:
          textController.text.isNotEmpty ? textController.text : 'Sent a file',
      fileName: hasPickedFile
          ? filePicked?.path.split(Platform.pathSeparator).last ?? ''
          : '',
      sentBy: context.read<LoginNotifier>().userId,
    );
    if (hasPickedFile) {
      var downloadUrl = await context.read<ChatProvider>().uploadFileToStorage(
          filePicked ?? File(''), msg.clientId, msg.influencerId);
      print("============> download url: $downloadUrl =========>");
      msg.downloadUrl = downloadUrl;
      filePicked = null;
      hasPickedFile = false;
    }
    Provider.of<ChatProvider>(context, listen: false).sendMessage(msg);

    if (widget.model.id.isEmpty && msgSent == null) {
      msgSent = await context.read<ChatProvider>().addChat(
          clientId ?? '',
          influencerId ?? '',
          textController.text,
          widget.isClientView ? clientId ?? '' : influencerId ?? '',
          widget.isClientView ? 'Client' : 'Influencer');
    } else {
      context.read<ChatProvider>().updateChat(
          msgSent?.id ?? widget.model.id,
          textController.text.isNotEmpty ? textController.text : 'Sent a file',
          widget.isClientView ? clientId ?? '' : influencerId ?? '',
          widget.isClientView ? 'Client' : 'Influencer');
    }

    setState(() {});
  }

  void pickFile() async {
    var pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['pdf'],
        type: FileType.custom);

    if (pickedFile != null) {
      filePicked = File(pickedFile.files.single.path ?? '');
      hasPickedFile = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isUploading = context.watch<ChatProvider>().uploadingFile;
    var isDownloading = context.watch<ChatProvider>().downloadingFile;
    var progress = context.watch<ChatProvider>().taskProgress;
    return LoadingOverlay(
      isLoading: isUploading || isDownloading,
      progressIndicator: AlertDialog.adaptive(
        backgroundColor: AppColors.lightMain,
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: CircularProgressIndicator(
                value: progress,
                backgroundColor: AppColors.dialogColor,
                color: AppColors.deepGreen,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomKarlaText(
                text:
                    isUploading ? 'Uploading file...' : 'Downloading file...'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (isUploading) {
                context.read<ChatProvider>().uploadTask?.cancel();
              } else {
                var taskId = context.read<ChatProvider>().currentTaskId ?? '';
                FileDownloader().cancelTaskWithId(taskId);
              }
            },
            style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(0),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.mainColor),
                    borderRadius: BorderRadius.circular(4))),
                backgroundColor: const MaterialStatePropertyAll(Colors.white)),
            child: const CustomKarlaText(
              text: "Cancel",
              size: 12,
              weight: FontWeight.w400,
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SafeArea(
            child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, finalMessage);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 70.w,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.dialogColor,
                          backgroundImage: NetworkImage(
                            widget.isClientView
                                ? widget.model.influencerId['imageURL']
                                : widget.model.companyOwnerId['profile'],
                          )),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomKarlaText(
                      text: widget.isClientView
                          ? widget.model.influencerId['firstAndLastName']
                          : widget.model.companyOwnerId['fullname'],
                      size: 14,
                      weight: FontWeight.w700,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: FirestoreListView<ChatMessages>(
                    query: chats.orderBy('timeStamp', descending: true),
                    pageSize: 20,
                    controller: listController,
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (context, snapshot) {
                      ChatMessages message = snapshot.data();
                      bool isUserMsg = message
                          .isSender(context.read<LoginNotifier>().userId);
                      return Align(
                        alignment: isUserMsg
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          child: ChatMessageBox(
                              isUserMessage: isUserMsg, message: message),
                        ),
                      );
                    })),
            Visibility(
                visible: hasPickedFile,
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F4F7),
                      borderRadius: BorderRadius.vertical(
                          top: const Radius.circular(6).r)),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomKarlaText(
                        text: filePicked?.path
                                .split(Platform.pathSeparator)
                                .last ??
                            '',
                      )),
                      IconButton(
                          onPressed: () {
                            filePicked = null;
                            hasPickedFile = false;
                            setState(() {});
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                )),
            SizedBox(
              height: 60.h,
              width: Get.width,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F4F7),
                        borderRadius: BorderRadius.circular(22).r),
                    child: Row(
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       pickEmoji = !pickEmoji;
                        //     });
                        //   },
                        //   child: const Icon(
                        //     Icons.emoji_emotions,
                        //     size: 18,
                        //     color: Color(0xff828A9C),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            onChanged: (text) => setState(() {
                              showSend =
                                  textController.text.isNotEmpty ? true : false;
                            }),
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.karla(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                                hintText: 'Type your message here...'),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 5.w,
                  ),
                  IconButton(
                      onPressed: () => pickFile(),
                      icon: const Icon(
                        Icons.description_outlined,
                        size: 25,
                        color: Color(0xff667085),
                      )),
                  // PopupMenuButton(
                  //     onSelected: (value) {
                  //       pickFile();
                  //     },
                  //     color: Colors.white,
                  //     elevation: 0,
                  //     itemBuilder: (context) => [
                  //           const PopupMenuItem(
                  //               value: 'Attach Document',
                  //               child: CustomKarlaText(
                  //                 text: 'Attach Document',
                  //               ))
                  //         ],
                  //     icon: const Icon(
                  //       Icons.description_outlined,
                  //       size: 25,
                  //       color: Color(0xff667085),
                  //     )),
                  if (showSend || hasPickedFile)
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              showSend = false;
                              sendMessage();
                              finalMessage = textController.text;
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              textController.clear();
                            },
                            child: const CircleAvatar(
                              backgroundColor: AppColors.mainColor,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    )
                ],
              ),
            ),
            // if (pickEmoji)
            //   Offstage(
            //     offstage: !pickEmoji,
            //     child: SizedBox(
            //       height: 200.h,
            //       child: EmojiPicker(
            //         textEditingController: textController,
            //         config: const Config(columns: 7, bgColor: Colors.white),
            //       ),
            //     ),
            //   )
          ],
        )),
      )),
    );
  }
}
