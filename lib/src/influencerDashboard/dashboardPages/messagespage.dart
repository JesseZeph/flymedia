import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/providers/chat_provider.dart';
import 'package:flymedia_app/utils/widgets/alert_loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../providers/login_provider.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/modal.dart';
import '../../clientdashboard/dashboardPages/messages.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
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
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
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
                        height: 27.h,
                      ),
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          var influencerId = await repository.retrieveData(
                              dataKey: 'InfluencerId');
                          if (context.mounted) {
                            context.read<ChatProvider>().fetchUserMessages(
                                influencerId ?? '', 'Influencer');
                          }
                        },
                        color: AppColors.mainColor,
                        child: const TabBarView(
                          children: [
                            Chats(
                              isClient: false,
                            ),
                            Groups(
                              isClient: false,
                            )
                          ],
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
