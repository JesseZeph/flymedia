import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/chat_provider.dart';
import 'package:flymedia_app/controllers/login_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/chat_page.dart';
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
              weight: FontWeight.w500,
              align: TextAlign.start,
              size: 14,
            ),
            subtitle: CustomKarlaText(
              text: chatModel.lastMessage,
              weight: FontWeight.w400,
              align: TextAlign.start,
              size: 12,
              color: chatModel.newMessagesCount > 0
                  ? AppColors.mainColor
                  : const Color(0xff2D2F34),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: chatModel.newMessagesCount > 0
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.mainColor,
                    child: CustomKarlaText(
                        text: chatModel.newMessagesCount.toString()),
                  )
                : null,
          ),
        ));
  }
}
