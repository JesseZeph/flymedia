// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/providers/chat_provider.dart';
import 'package:flymedia_app/models/chats/chats_messages.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';

class ChatMessageBox extends StatefulWidget {
  const ChatMessageBox(
      {super.key, required this.message, required this.isUserMessage});
  final ChatMessages message;
  final bool isUserMessage;

  @override
  State<ChatMessageBox> createState() => _ChatMessageBoxState();
}

class _ChatMessageBoxState extends State<ChatMessageBox> {
  downloadFile() async {
    if (Platform.isAndroid) {
      await permissionsAllowed().then((permissionsGranted) {
        if (!permissionsGranted) {
          context.showError('Grant permissions to download files.');
          return;
        }
      });
    }
    var downloadTask = DownloadTask(
        taskId: ObjectId().toString(),
        url: widget.message.downloadUrl ?? '',
        filename: widget.message.fileName,
        updates: Updates.progress,
        directory: 'flymedia/downloads');
    context
        .read<ChatProvider>()
        .downloadFile(downloadTask)
        .then((result) async {
      if (result == null || result.status != TaskStatus.complete) {
        context.showError('Could not download File.');
      } else {
        FileDownloader()
            .moveToSharedStorage(downloadTask, SharedStorage.downloads)
            .then(
          (_) {
            context.showSuccess('File downloaded successfully');
          },
        );
      }
    });
  }

  Future<bool> permissionsAllowed() async {
    const permissionType = PermissionType.androidSharedStorage;
    var status = await FileDownloader().permissions.status(permissionType);
    if (status != PermissionStatus.granted) {
      status = await FileDownloader().permissions.request(permissionType);
    }
    return status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    // var lastUploadTime = context.watch<ChatProvider>().uploadTime;
    // var progress = context.watch<ChatProvider>().uploadProgress;
    return Container(
      padding: const EdgeInsets.all(14).r,
      decoration: BoxDecoration(
        color: widget.isUserMessage
            ? AppColors.mainColor
            : const Color(0xffF2F4F7),
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
            topRight:
                widget.isUserMessage ? Radius.zero : const Radius.circular(8),
            topLeft:
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
                        Icon(
                          Icons.file_present_outlined,
                          color: widget.isUserMessage
                              ? Colors.white
                              : Colors.black,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: CustomKarlaText(
                            text: widget.message.fileName ?? '',
                            align: TextAlign.start,
                            weight: FontWeight.w400,
                            color: widget.isUserMessage
                                ? Colors.white
                                : Colors.black,
                            size: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                            widget.isUserMessage ? Colors.white : Colors.black,
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
                          downloadFile();
                        },
                        icon: Icon(
                          Icons.download_for_offline_outlined,
                          color: widget.isUserMessage
                              ? Colors.white
                              : Colors.black,
                        ),
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
                color: widget.isUserMessage ? Colors.white : Colors.black,
                size: 14,
              ),
      ),
    );
  }
}

class GroupMessageBox extends StatefulWidget {
  const GroupMessageBox(
      {super.key,
      required this.message,
      required this.isUserMessage,
      required this.otherUserId});
  final GroupMessages message;
  final bool isUserMessage;
  final String otherUserId;

  @override
  State<GroupMessageBox> createState() => _GroupMessageBoxState();
}

class _GroupMessageBoxState extends State<GroupMessageBox> {
  downloadFile() async {
    if (Platform.isAndroid) {
      await permissionsAllowed().then((permissionsGranted) {
        if (!permissionsGranted) {
          context.showError('Grant permissions to download files.');
          return;
        }
      });
    }
    var downloadTask = DownloadTask(
        taskId: ObjectId().toString(),
        url: widget.message.downloadUrl ?? '',
        filename: widget.message.fileName,
        updates: Updates.progress,
        directory: 'flymedia/downloads');
    context
        .read<ChatProvider>()
        .downloadFile(downloadTask)
        .then((result) async {
      if (result == null || result.status != TaskStatus.complete) {
        context.showError('Could not download File.');
      } else {
        FileDownloader()
            .moveToSharedStorage(downloadTask, SharedStorage.downloads)
            .then(
          (_) {
            context.showSuccess('File downloaded successfully');
          },
        );
      }
    });
  }

  Future<bool> permissionsAllowed() async {
    const permissionType = PermissionType.androidSharedStorage;
    var status = await FileDownloader().permissions.status(permissionType);
    if (status != PermissionStatus.granted) {
      status = await FileDownloader().permissions.request(permissionType);
    }
    return status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    // var lastUploadTime = context.watch<ChatProvider>().uploadTime;
    // var progress = context.watch<ChatProvider>().uploadProgress;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isUserMessage)
          Padding(
            padding: EdgeInsets.only(right: 8.r),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage(widget.message.senderImg ?? ''),
            ),
          ),
        Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10).r,
            decoration: BoxDecoration(
              color: widget.isUserMessage
                  ? AppColors.mainColor
                  : const Color(0xffF2F4F7),
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(8),
                  bottomRight: const Radius.circular(8),
                  topRight: widget.isUserMessage
                      ? Radius.zero
                      : const Radius.circular(8),
                  topLeft: widget.isUserMessage
                      ? const Radius.circular(8)
                      : Radius.zero),
            ),
            child: SizedBox(
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.isUserMessage)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: CustomKarlaText(
                          text: widget.message.senderName ?? '',
                          weight: FontWeight.w800,
                          color: widget.message
                              .nameDisplayColor(widget.otherUserId),
                        ),
                      ),
                    widget.message.isFile
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: widget.isUserMessage
                                        ? const Color(0xffF2F4F7)
                                        : AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(6).r),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_present_outlined,
                                      color: widget.isUserMessage
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: CustomKarlaText(
                                        text: widget.message.fileName ?? '',
                                        align: TextAlign.start,
                                        weight: FontWeight.w400,
                                        color: widget.isUserMessage
                                            ? Colors.black
                                            : Colors.white,
                                        size: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomKarlaText(
                                    text: widget.message.text ?? '',
                                    align: TextAlign.start,
                                    weight: FontWeight.w400,
                                    color: widget.isUserMessage
                                        ? Colors.white
                                        : Colors.black,
                                    size: 14,
                                  )),
                                  IconButton(
                                    onPressed: () {
                                      downloadFile();
                                    },
                                    icon: Icon(
                                      Icons.download_for_offline_outlined,
                                      color: widget.isUserMessage
                                          ? Colors.white
                                          : Colors.black,
                                    ),
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
                            color: widget.isUserMessage
                                ? Colors.white
                                : Colors.black,
                            size: 14,
                          ),
                  ],
                ))),
      ],
    );
  }
}
