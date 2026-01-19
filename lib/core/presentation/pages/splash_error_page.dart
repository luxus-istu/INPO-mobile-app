import 'package:flutter/material.dart';

class SplashErrorPage extends StatelessWidget {
  final Exception error;
  const SplashErrorPage(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF4069D3),
        child: SafeArea(
          bottom: false,
          minimum: const EdgeInsets.only(
              top: 106), // Фиксированный отступ для мобильных
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
                      fontSize: 40, // Фиксированный размер шрифта для мобильных
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Фиксированный отступ для мобильных
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ИЖГТУ',
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                    Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
