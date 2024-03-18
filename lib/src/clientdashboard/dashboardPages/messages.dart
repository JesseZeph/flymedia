import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';
import 'package:flymedia_app/utils/widgets/chat_tile.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';
import '../../../providers/login_provider.dart';
import '../../../utils/modal.dart';
import '../../../utils/widgets/alert_loader.dart';

class ClientMessagePage extends StatefulWidget {
  const ClientMessagePage({super.key});

  @override
  State<ClientMessagePage> createState() => _ClientMessagePageState();
}

class _ClientMessagePageState extends State<ClientMessagePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    var loading = context.watch<ChatProvider>().fetchingChat;
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : LoadingOverlay(
            isLoading: loading,
            progressIndicator: const AlertLoader(message: 'Fetching chats'),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Messages",
                    style: GoogleFonts.karla(
                        fontSize: 18.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                  child: SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: AppColors.deepGreen),
                        child: const TabBar(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            dividerHeight: 0,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Text('Chats'),
                              ),
                              Tab(
                                child: Text('Groups'),
                              ),
                            ]),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showSearch(
                      //         context: context,
                      //         delegate:
                      //             MessageSearchDelegate(isClientView: true));
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                      //     height: 43.h,
                      //     width: 358.w,
                      //     decoration: BoxDecoration(
                      //         color: const Color(0xffF2F4F7),
                      //         borderRadius: BorderRadius.circular(24).r),
                      //     child: Row(
                      //       children: [
                      //         const Icon(
                      //           Icons.search,
                      //           size: 20,
                      //           color: Color(0xff667085),
                      //         ),
                      //         SizedBox(width: 5.w),
                      //         Text(
                      //           "Search",
                      //           style: GoogleFonts.karla(
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: 12.sp,
                      //             color: const Color(0xff667085),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () => context
                            .read<ChatProvider>()
                            .fetchUserMessages(
                                context.read<LoginNotifier>().userId, 'Client'),
                        color: AppColors.mainColor,
                        child: const TabBarView(
                          children: [_Chats(), _Groups()],
                        ),
                      ))
                    ],
                  )),
                ),
              ),
            ),
          );
  }
}

class _Chats extends StatefulWidget {
  const _Chats();

  @override
  State<_Chats> createState() => __ChatsState();
}

class __ChatsState extends State<_Chats> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var chatList = context.watch<ChatProvider>().userMessages;
    return chatList.isEmpty
        ? const Center(
            child: CustomKarlaText(
              text: 'No messages here',
              weight: FontWeight.bold,
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ChatTile(
              isClientView: true,
              model: chatList[index],
              index: index,
            ),
            separatorBuilder: (context, index) => Divider(
              color: const Color(0xffF0F2F6),
              height: 10.h,
            ),
            itemCount: chatList.length,
          );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Groups extends StatefulWidget {
  const _Groups();

  @override
  State<_Groups> createState() => __GroupsState();
}

class __GroupsState extends State<_Groups> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var groupList = context.watch<ChatProvider>().userGroups;

    return groupList.isEmpty
        ? const Center(
            child: CustomKarlaText(
              text: 'No groups here',
              weight: FontWeight.bold,
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => GroupChatTile(
              isClient: true,
              model: groupList[index],
            ),
            separatorBuilder: (context, index) => Divider(
              color: const Color(0xffF0F2F6),
              height: 10.h,
            ),
            itemCount: groupList.length,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
