import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/controllers/campaign_provider.dart';
import 'package:flymedia_app/controllers/chat_provider.dart';
import 'package:flymedia_app/controllers/profile_provider.dart';
import 'package:flymedia_app/firebase_options.dart';
import 'package:flymedia_app/services/helpers/applications_helper.dart';
import 'package:flymedia_app/services/helpers/forgot_password_helper.dart';
import 'package:flymedia_app/src/accountoption/view.dart';
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
import 'src/clientdashboard/screens/verificationinprogress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget? defaultHome;
  try {
    final selectedContainer = prefs.getInt('selectedContainer') ?? 0;

    switch (selectedContainer) {
      case 1:
        defaultHome = const ClientHomePage();
        break;
      case 2:
        defaultHome = const InfluencerHomePage();
        break;
      case 3:
        defaultHome = const AccountOption();
        break;
      case 4:
        defaultHome = const VerificationInProgress(
          shouldValidateCompany: true,
        );
        break;
      default:
        defaultHome = const SplashScreen();
    }
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
  } finally {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
        ChangeNotifierProvider(create: (context) => ApplicationsHelper()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordHelper()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => SignUpNotifier()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
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
            home: defaultHome ?? const SplashScreen(),
          );
        },
      ),
    ));
  }
}
