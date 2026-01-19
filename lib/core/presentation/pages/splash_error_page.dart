import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

class SplashErrorPage extends StatelessWidget {
  final Exception error;
  final VoidCallback? retry;
  final String? buttonMessage;
  const SplashErrorPage(
    this.error, {
    super.key,
    this.retry,
    this.buttonMessage,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
                    localizations.brandName,
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
                      localizations.universityName,
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
              Align(
                alignment: AlignmentGeometry.bottomRight,
                child: Image.asset(
                  "assets/images/statue_cutted.png",
                  fit: BoxFit.contain,
                  scale: 2, // Фиксированный масштаб для мобильных
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      localizations.errorOccurred,
                      style: TextStyle(
                        fontFamily: "Onder",
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: this.retry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF4069D3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        this.buttonMessage ?? localizations.tryAgain,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
