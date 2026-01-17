import 'package:inpo_mobile_app/config/router/router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure image caching before any widgets are built
  ImageService.configureImageCache();

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base design size (iPhone 13)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: false,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          color: Colors.white,
          title: 'INPO Mobile App',
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(
                    start: 451, end: double.infinity, name: TABLET),
              ],
            );
          },
          routerConfig: router,
        );
      },
    );
  }
}
