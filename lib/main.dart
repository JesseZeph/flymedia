import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/campaign_provider.dart';
import 'package:flymedia_app/src/clientdashboard/clientHomepage.dart';
import 'package:flymedia_app/src/influencerDashboard/influencerHomepage.dart';
import 'package:flymedia_app/src/onboardingscreen/onboarding.dart';
import 'package:flymedia_app/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/login_provider.dart';
import 'controllers/onboarding_provider.dart';
import 'controllers/signup_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final selectedContainer = prefs.getInt('selectedContainer') ?? 0;

  Widget defaultHome;
  if (selectedContainer == 1) {
    defaultHome = const ClientHomePage();
  } else if (selectedContainer == 2) {
    defaultHome = const InfluencerHomePage();
  } else {
    defaultHome = const SplashScreen();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => SignUpNotifier()),
      ChangeNotifierProvider(create: (context) => CampaignsNotifier()),
    ],
    child: ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flymedia',
          theme: lightTheme,
          home: defaultHome,
        );
      },
    ),
  ));
}
