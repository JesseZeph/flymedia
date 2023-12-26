import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/utils/widgets/chat_tile.dart';
import 'package:flymedia_app/utils/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../controllers/chat_provider.dart';
import '../../../controllers/login_provider.dart';
import '../../../utils/modal.dart';
import '../../../utils/widgets/alert_loader.dart';
import '../../../utils/widgets/search_msg_delegate.dart';

class ClientMessagePage extends StatelessWidget {
  const ClientMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    var loading = context.watch<ChatProvider>().fetchingChat;
    var chatList = context.watch<ChatProvider>().userMessages.reversed.toList();
    return loginNotifier.loggedIn == false
        ? ModalWidget(context: context)
        : LoadingOverlay(
            isLoading: loading,
            progressIndicator: const AlertLoader(message: 'Fetching chats'),
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
                child: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate:
                                MessageSearchDelegate(isClientView: true));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        height: 43.h,
                        width: 358.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F4F7),
                            borderRadius: BorderRadius.circular(24).r),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xff667085),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Search",
                              style: GoogleFonts.karla(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: const Color(0xff667085),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Expanded(
                        child: chatList.isEmpty
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
                                ),
                                separatorBuilder: (context, index) => Divider(
                                  color: const Color(0xffF0F2F6),
                                  height: 10.h,
                                ),
                                itemCount: chatList.length,
                              ))
                  ],
                )),
              ),
            ),
          );
  }
}
