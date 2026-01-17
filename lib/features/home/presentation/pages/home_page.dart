import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/lazy_image_widget.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/image_collage_widget.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/responsive_helper.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
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
      imagePath: "assets/images/home_image_0.webp",
      title: "Постоянное участие в\nмеждународных конкурсах и\nолимпиадах",
    ),
    _HomeCardData(
      imagePath: "assets/images/home_image_1.webp",
      title: "Креативная студенческая\nжизнь",
    ),
    _HomeCardData(
      imagePath: "assets/images/home_image_2.webp",
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
    // Get responsive values based on screen size
    final isTablet = context.isTablet;
    final isMobile = context.isMobile;

    // Responsive dimensions
    final imageHeight = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: context.screenHeight * 0.7,
      tablet: context.screenHeight * 0.6,
    );

    final cardHeight = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: context.screenWidth * 0.6,
      tablet: context.screenWidth * 0.4,
    );

    final titleFontSize = ResponsiveHelper.responsiveFontSize(
      context: context,
      mobile: context.screenWidth < 360 ? 28.0 : 32.0,
      tablet: 36.0,
    );

    final cardFontSize = ResponsiveHelper.responsiveFontSize(
      context: context,
      mobile: context.screenWidth < 360 ? 18.0 : 20.0,
      tablet: 22.0,
    );

    final spacing = ResponsiveHelper.responsiveSpacing(
      context: context,
      mobile: context.screenHeight * 0.03,
      tablet: context.screenHeight * 0.04,
    );

    // Determine layout based on screen size
    final crossAxisCount = ResponsiveHelper.responsiveGridColumns(
      context: context,
      mobile: 1,
      tablet: 2,
    );

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
                    child: ImageCollageWidget(
                      imageUrls: imageUrls,
                      isTablet: isTablet,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                    ),
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
                        // Use grid layout for tablets/desktop, list for mobile
                        if (isMobile)
                          ...List.generate(_cardsData.length, (index) {
                            final card = _cardsData[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == _cardsData.length - 1
                                    ? 0
                                    : spacing,
                              ),
                              child: _buildCardWidget(
                                imagePath: card.imagePath,
                                title: card.title,
                                cardHeight: cardHeight,
                                fontSize: cardFontSize,
                              ),
                            );
                          })
                        else
                          GridView.count(
                            crossAxisCount: crossAxisCount,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: spacing,
                            crossAxisSpacing: spacing,
                            children: List.generate(_cardsData.length, (index) {
                              final card = _cardsData[index];
                              return _buildCardWidget(
                                imagePath: card.imagePath,
                                title: card.title,
                                cardHeight: cardHeight,
                                fontSize: cardFontSize,
                              );
                            }),
                          ),
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
          child: LazyImageWidget(
            imageUrl: imagePath,
            width: double.infinity,
            height: cardHeight,
            fit: BoxFit.cover,
            borderRadius: 15,
            placeholder: Container(
              width: double.infinity,
              height: cardHeight,
              color: Colors.grey[100],
              child: const Icon(
                Icons.image,
                size: 32,
                color: Colors.grey,
              ),
            ),
            errorWidget: Container(
              width: double.infinity,
              height: cardHeight,
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                size: 40,
                color: Colors.grey,
              ),
            ),
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
