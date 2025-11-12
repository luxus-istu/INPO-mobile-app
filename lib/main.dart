import 'package:inpo_mobile_app/config/router/router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      color: Colors.white,
      title: 'INPO Mobile App',
      routerConfig: router,
    );
  }
}
