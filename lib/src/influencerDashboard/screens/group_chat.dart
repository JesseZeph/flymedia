import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/models/chats/group_chat.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/utils/global_variables.dart';
import 'package:flymedia_app/utils/widgets/chat_message_box.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../providers/chat_provider.dart';
import '../../../utils/widgets/custom_text.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage(
      {super.key, required this.model, required this.isClientView});
  final GroupChat model;
  final bool isClientView;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  var textController = TextEditingController();
  bool showSend = false;
  late ScrollController listController;
  String? lastMessage;
  late Query<GroupMessages> chats;
  bool pickEmoji = false;
  String? id;
  String? name;
  bool hasPickedFile = false;
  File? filePicked;
  GroupChat? msgSent;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
    id = widget.isClientView ? widget.model.client : widget.model.influencer;
    chats = context
        .read<ChatProvider>()
        .groupChatStream(groupName: widget.model.groupName);
  }

  void sendMessage() async {
    String? name;
    String? img;
    if (widget.isClientView) {
      name = await repository.retrieveData(dataKey: 'companyName');
    } else {
      name = context.read<ProfileProvider>().userProfile?.firstAndLastName;
      img = context.read<ProfileProvider>().userProfile?.imageUrl;
    }

    GroupMessages msg = GroupMessages(
        type: hasPickedFile ? 'File' : 'Text',
        senderName: name,
        senderId: id,
        senderImg: widget.isClientView ? widget.model.groupImage : img,
        text: lastMessage ?? 'Sent a file',
        fileName: hasPickedFile
            ? filePicked?.path.split(Platform.pathSeparator).last ?? ''
            : null);
    if (hasPickedFile) {
      if (mounted) {
        var downloadUrl = await context
            .read<ChatProvider>()
            .uploadFileToStorage(filePicked ?? File(''), widget.model.client,
                widget.model.influencer);
        msg.downloadUrl = downloadUrl;
        filePicked = null;
        hasPickedFile = false;
      }
    }
    if (!mounted) return;
    Provider.of<ChatProvider>(context, listen: false)
        .sendGroupMessage(msg, widget.model.groupName);
    context.read<ChatProvider>().updateChat(
        msgSent?.id ?? widget.model.id,
        lastMessage ?? 'Sent a file',
        id ?? '',
        widget.isClientView ? 'Client' : 'Influencer',
        isGroup: true);

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
      child: PopScope(
        canPop: !isUploading && !isDownloading,
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SafeArea(
              child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context, lastMessage);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 70.h,
                    width: 70.w,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.dialogColor,
                        backgroundImage: NetworkImage(widget.model.groupImage)),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomKarlaText(
                    text: widget.model.groupName,
                    size: 14,
                    weight: FontWeight.w700,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: FirestoreListView<GroupMessages>(
                      query: chats.orderBy('timeStamp', descending: true),
                      pageSize: 20,
                      controller: listController,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        GroupMessages message = snapshot.data();
                        bool isUserMsg = message.isSender(id ?? '');
                        return Align(
                          alignment: isUserMsg
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            child: GroupMessageBox(
                                otherUserId: widget.isClientView
                                    ? widget.model.influencer
                                    : widget.model.client,
                                isUserMessage: isUserMsg,
                                message: message),
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
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F4F7),
                          borderRadius: BorderRadius.circular(22).r),
                      child: TextFormField(
                        maxLines: null,
                        minLines: 1,
                        controller: textController,
                        onChanged: (text) => setState(() {
                          showSend =
                              textController.text.isNotEmpty ? true : false;
                        }),
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.karla(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                            hintText: 'Type your message here...'),
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
                    if (showSend || hasPickedFile)
                      Row(
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                showSend = false;
                                lastMessage = textController.text;
                                sendMessage();
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
            ],
          )),
        )),
      ),
    );
  }
}
