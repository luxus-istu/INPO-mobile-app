import 'package:databank_mobile_app/config/theme/theme.dart';
import 'package:databank_mobile_app/core/di/injection.dart';
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
    return MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        title: 'Databank Mobile App',
        home: const AuthWrapper());
  }
}
