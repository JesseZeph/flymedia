import 'dart:async';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/providers/profile_provider.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/campaignpage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/messagespage.dart';
import 'package:flymedia_app/src/influencerDashboard/dashboardPages/profile.dart';
import 'package:flymedia_app/src/influencerDashboard/screens/influencer_menu.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../../providers/chat_provider.dart';
import '../../route/route.dart';
import '../../services/database/secure_storage.dart';
import '../../services/helpers/applications_helper.dart';
import '../../utils/global_variables.dart';
import '../accountoption/view.dart';

class InfluencerHomePage extends StatefulWidget {
  const InfluencerHomePage({super.key});

  @override
  State<InfluencerHomePage> createState() => _InfluencerHomePage();
}

class _InfluencerHomePage extends State<InfluencerHomePage> {
  int _selectedIndex = 0;
  Timer? timer;
  final TooltipController _controller = TooltipController();

  var pages = <Widget>[
    const CampaignPage(),
    const MessagePage(),
    const ProfilePage(),
    const InfluencerMenu()
  ];

  @override
  void initState() {
    super.initState();
    checkTooltipDisplay();
    loadInfo();
    validateToken();
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      SharedPreferences.getInstance().then((prefs) {
        context.read<ChatProvider>().fetchUserMessages(
            prefs.getString('influencerId') ??
                context.read<LoginNotifier>().userId,
            "Influencer");
      });
    });
  }

  checkTooltipDisplay() async {
    var tooltipShown =
        await repository.retrieveData(dataKey: SecureStore.toolInfluencer);
    if (tooltipShown == 'false' || tooltipShown == null) {
      _controller.start();
      _controller.onDone(() {
        repository.storeData(
            dataKey: SecureStore.toolInfluencer, value: 'true');
      });
    }
  }

  loadInfo() {
    context.read<LoginNotifier>().getPref();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('selectedContainer', 2);
      context
          .read<ProfileProvider>()
          .getProfile(prefs.getString('userId') ?? '');
      context.read<ChatProvider>().fetchUserMessages(
          prefs.getString('influencerId') ??
              context.read<LoginNotifier>().userId,
          "Influencer");
    });
  }

  validateToken() async {
    await context.read<ApplicationsHelper>().validateToken().then((isValid) {
      if (!isValid) {
        context.read<LoginNotifier>().logout();
        pushToAndClearStack(context, const AccountOption());
        if (mounted) context.showError('Session Expired, log in.');
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      controller: _controller,
      overlayColor: Colors.white.withOpacity(1.0),
      preferredOverlay: GestureDetector(
        onTap: () => _controller.next(),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(1.0)),
      ),
      builder: (context) => Scaffold(
        body: Center(
          child: pages[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            elevation: 10,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: AppColors.lightHintTextColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_note_add_regular),
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_note_add_filled),
                  label: 'Campaigns'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline_rounded),
                  activeIcon: Icon(Icons.mail),
                  label: 'Messages'),
              BottomNavigationBarItem(
                  icon:
                      Icon(FluentSystemIcons.ic_fluent_person_accounts_regular),
                  activeIcon:
                      Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
                  label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  activeIcon: Icon(Icons.menu_open),
                  label: 'Menu'),
            ]),
      ),
    );
  }
}
