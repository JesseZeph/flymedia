import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/chats/group_chat.dart';
import 'package:flymedia_app/providers/chat_provider.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/chat_page.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/group_chat.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/chats/chat_model.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key, required this.model, required this.isClientView});
  final ChatModel model;
  final bool isClientView;

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  late ChatModel chatModel;

  @override
  void initState() {
    super.initState();
    chatModel = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.h,
        width: 390.w,
        child: Center(
          child: ListTile(
            onTap: () async {
              context.read<ChatProvider>().updateChatStatus(
                  chatModel.id,
                  context.read<LoginNotifier>().userId,
                  widget.isClientView ? 'Client' : "Influencer");
              String? lastMsg = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      isClientView: widget.isClientView,
                      model: chatModel,
                    ),
                  ));
              if (mounted) {
                chatModel.lastMessage = lastMsg ?? chatModel.lastMessage;
                setState(() {});
              }
            },
            leading: SizedBox(
              width: 50.w,
              height: 50.h,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.dialogColor,
                  backgroundImage: NetworkImage(
                    widget.isClientView
                        ? chatModel.influencerId['imageURL']
                        : chatModel.companyOwnerId['profile'],
                  )),
            ),
            title: CustomKarlaText(
              text: widget.isClientView
                  ? chatModel.influencerId['firstAndLastName']
                  : chatModel.companyOwnerId['fullname'],
              weight: FontWeight.w700,
              align: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              size: 14,
            ),
            subtitle: CustomKarlaText(
              text: chatModel.lastMessage,
              weight: FontWeight.w400,
              align: TextAlign.start,
              size: 12,
              color: chatModel.hasNewMessages(widget.isClientView)
                  ? AppColors.mainColor
                  : const Color(0xff2D2F34),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: chatModel.hasNewMessages(widget.isClientView)
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.mainColor,
                    child: CustomKarlaText(
                        text: widget.isClientView
                            ? chatModel.newMessagesCountClient.toString()
                            : chatModel.newMessagesCount.toString()),
                  )
                : null,
          ),
        ));
  }
}

class GroupChatTile extends StatefulWidget {
  const GroupChatTile({super.key, required this.model, required this.isClient});
  final GroupChat model;
  final bool isClient;

  @override
  State<GroupChatTile> createState() => _GroupChatTileState();
}

class _GroupChatTileState extends State<GroupChatTile> {
  late GroupChat chatModel;

  @override
  void initState() {
    super.initState();
    chatModel = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.h,
        width: 390.w,
        child: Center(
          child: ListTile(
            onTap: () async {
              context.read<ChatProvider>().updateChatStatus(
                  chatModel.id,
                  context.read<LoginNotifier>().userId,
                  widget.isClient ? 'Client' : "Influencer",
                  isGroup: true);
              String? lastMsg = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupChatPage(
                      isClientView: widget.isClient,
                      model: chatModel,
                    ),
                  ));
              if (mounted) {
                chatModel.lastMessage = lastMsg ?? chatModel.lastMessage;
                setState(() {});
              }
            },
            leading: SizedBox(
              width: 50.w,
              height: 50.h,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.dialogColor,
                  backgroundImage: NetworkImage(chatModel.groupImage)),
            ),
            title: CustomKarlaText(
              text: chatModel.groupName,
              weight: FontWeight.w700,
              align: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              size: 14,
            ),
            subtitle: CustomKarlaText(
              text: chatModel.lastMessage,
              weight: FontWeight.w400,
              align: TextAlign.start,
              size: 12,
              color: chatModel.hasNewMessages(widget.isClient)
                  ? AppColors.mainColor
                  : const Color(0xff2D2F34),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: chatModel.hasNewMessages(widget.isClient)
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.mainColor,
                    child: CustomKarlaText(
                        text: widget.isClient
                            ? chatModel.newMessageCountClient.toString()
                            : chatModel.newMessageCountClient.toString()),
                  )
                : null,
          ),
        ));
  }
}
