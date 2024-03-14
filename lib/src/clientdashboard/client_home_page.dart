import 'dart:async';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flymedia_app/providers/chat_provider.dart';
import 'package:flymedia_app/providers/login_provider.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/src/clientdashboard/dashboardPages/campaign.dart';
import 'package:flymedia_app/utils/extensions/context_extension.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../../providers/campaign_provider.dart';
import '../../route/route.dart';
import '../../services/database/secure_storage.dart';
import '../../utils/global_variables.dart';
import '../accountoption/view.dart';
import 'dashboardPages/help.dart';
import 'dashboardPages/messages.dart';
import 'dashboardPages/menu.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({
    super.key,
  });

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _selectedIndex = 0;
  final TooltipController _controller = TooltipController();
  static final List<Widget> _widgetOptions = <Widget>[
    const Campaign(),
    const ClientMessagePage(),
    const ClientHelp(),
    const Menu(),
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkTooltipDisplay();
    fetchData();
    validateToken();
    // timer = Timer.periodic(const Duration(seconds: 5), (_) {
    //   context
    //       .read<ChatProvider>()
    //       .fetchUserMessages(context.read<LoginNotifier>().userId, "Client");
    // });
  }

  checkTooltipDisplay() async {
    var tooltipShown =
        await repository.retrieveData(dataKey: SecureStore.toolClient);
    if (tooltipShown == 'false' || tooltipShown == null) {
      _controller.start();
      _controller.onDone(() {
        repository.storeData(dataKey: SecureStore.toolClient, value: 'true');
      });
    }
  }

  fetchData() async {
    // context.read<SubscriptionProvider>().init();
    await context.read<LoginNotifier>().getPref().then((_) {
      context
          .read<CampaignsNotifier>()
          .getClientCampaigns(context.read<LoginNotifier>().userId);
      context
          .read<ChatProvider>()
          .fetchUserMessages(context.read<LoginNotifier>().userId, "Client");
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('selectedContainer', 1);
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
    _controller.dispose();
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
          child: _widgetOptions[_selectedIndex],
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
                  icon: Icon(FluentSystemIcons.ic_fluent_help_circle_regular),
                  activeIcon:
                      Icon(FluentSystemIcons.ic_fluent_help_circle_filled),
                  label: 'Help'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  activeIcon: Icon(Icons.menu_open),
                  label: 'Menu'),
            ]),
      ),
    );
  }
}
