import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class SplashLoadingPage extends StatelessWidget {
  const SplashLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        color: const Color(0xFF4069D3),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.brandName,
                    style: TextStyle(
                      fontFamily: "Onder",
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 40, // Фиксированный размер шрифта для мобильных
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Фиксированный отступ для мобильных
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      localization.universityName,
                      style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            28, // Фиксированный размер шрифта для мобильных
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/statue_cutted.png",
                  fit: BoxFit.contain,
                  scale: 2, // Фиксированный масштаб для мобильных
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
