import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4069D3),
      child: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.only(top: 106),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.brandName,
                    style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        color: Colors.white)),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(AppLocalizations.of(context)!.universityName,
                      style: TextStyle(
                          fontFamily: "Onder",
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          color: Colors.white)),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/images/statue_cutted.png",
                fit: BoxFit.contain,
                scale: 2,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
