import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/onboardingscreen/onboarding.dart';
import 'package:flymedia_app/utils/theme/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: lightTheme,
          title: 'FlyMedia',
          debugShowCheckedModeBanner: false,
          // home: TestPage(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
