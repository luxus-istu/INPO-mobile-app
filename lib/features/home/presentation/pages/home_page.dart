import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/image_collage_widget.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  static const List<_HomeCardData> _cardsData = [
    _HomeCardData(
      imagePath: "assets/images/home_image_0.jpg",
      title: "Постоянное участие в\nмеждународных конкурсах и\nолимпиадах",
    ),
    _HomeCardData(
      imagePath: "assets/images/home_image_1.jpg",
      title: "Креативная студенческая\nжизнь",
    ),
    _HomeCardData(
      imagePath: "assets/images/home_image_2.jpg",
      title: "Большое разнообразие\nспециальностей",
    ),
  ];

  @override
  void initState() {
    super.initState();
    getIt<NewsBloc>().add(const FetchNews());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    final imageHeight = screenHeight * 0.7;
    final cardHeight = screenWidth * 0.6;
    final titleFontSize = screenWidth < 360 ? 28.0 : 32.0;
    final cardFontSize = screenWidth < 360 ? 18.0 : 20.0;
    final spacing = screenHeight * 0.03;

    return BlocBuilder<NewsBloc, NewsState>(
      bloc: getIt<NewsBloc>(),
      builder: (context, state) {
        if (state is NewsLoaded) {
          final imageUrls = state.news
              .map((newsItem) => newsItem.imageUrl ?? "")
              .take(6)
              .toList();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderWidget(labelName: "ГЛАВНАЯ\nСТРАНИЦА"),
                  SizedBox(
                    height: imageHeight,
                    child: ImageCollageWidget(imageUrls: imageUrls),
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          "Почему мы?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w700,
                            fontSize: titleFontSize,
                            color: const Color(0xFF899ED4),
                          ),
                        ),
                        SizedBox(height: spacing),
                        ...List.generate(_cardsData.length, (index) {
                          final card = _cardsData[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  index == _cardsData.length - 1 ? 0 : spacing,
                            ),
                            child: _buildCardWidget(
                              imagePath: card.imagePath,
                              title: card.title,
                              cardHeight: cardHeight,
                              fontSize: cardFontSize,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing * 2),
                ],
              ),
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }

        return const SplashScreen();
      },
    );
  }

  Widget _buildCardWidget({
    required String imagePath,
    required String title,
    required double cardHeight,
    required double fontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: cardHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: cardHeight,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            fontFamily: "SF Pro Display",
            color: const Color(0xFF4069D3),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _HomeCardData {
  final String imagePath;
  final String title;
  const _HomeCardData({required this.imagePath, required this.title});
}
