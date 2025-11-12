import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4069D3),
      child: SafeArea(
        bottom: false,
        minimum: EdgeInsets.only(
          top: Responsive.getResponsiveValue(
            context,
            mobile: 106,
            tablet: 120,
            desktop: 140,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ИНПО',
                  style: TextStyle(
                    fontFamily: "Onder",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.getResponsiveValue(
                      context,
                      mobile: 40,
                      tablet: 56,
                      desktop: 72,
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.getResponsiveValue(
                  context,
                  mobile: 10,
                  tablet: 16,
                  desktop: 20,
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ИЖГТУ',
                    style: TextStyle(
                      fontFamily: "Onder",
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.getResponsiveValue(
                        context,
                        mobile: 28,
                        tablet: 40,
                        desktop: 52,
                      ),
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
                scale: Responsive.getResponsiveValue(
                  context,
                  mobile: 2,
                  tablet: 1.5,
                  desktop: 1.2,
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
