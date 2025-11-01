import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ИНПО',
                    style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        color: Colors.white)),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('ИЖГТУ',
                      style: TextStyle(
                          fontFamily: "Onder",
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          color: Colors.white)),
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
