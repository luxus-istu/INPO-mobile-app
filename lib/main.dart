import 'package:inpo_mobile_app/config/router/router.dart';
import 'package:inpo_mobile_app/config/theme/theme.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      title: 'INPO Mobile App',
      routerConfig: router,
    );
  }
}
