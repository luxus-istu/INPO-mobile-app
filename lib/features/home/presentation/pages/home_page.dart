import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/image_collage_widget.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<NewsBloc>().add(const FetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: getIt<NewsBloc>(),
      builder: (context, state) {
        if (state is NewsLoaded) {
          final imageUrls = state.news
              .map((newsItem) => newsItem.imageUrl ?? "")
              .take(6)
              .toList();
          final cardsData = const [
            _HomeCardData(
              imagePath: "assets/images/home_image_0.jpg",
              title:
                  "Постоянное участие в\nмеждународных конкурсах и\nолимпиадах",
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

          final isTablet = Responsive.isTablet(context);
          final isDesktop = Responsive.isDesktop(context);
          final maxWidth = Responsive.getMaxContentWidth(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView(
                  padding: Responsive.getResponsivePadding(
                    context,
                    mobile: EdgeInsets.zero,
                    tablet: const EdgeInsets.symmetric(horizontal: 24),
                    desktop: const EdgeInsets.symmetric(horizontal: 32),
                  ),
                  children: [
                    const HeaderWidget(labelName: "ГЛАВНАЯ\nСТРАНИЦА"),
                    ImageCollageWidget(imageUrls: imageUrls),
                    Padding(
                      padding: Responsive.getResponsivePadding(
                        context,
                        mobile: const EdgeInsets.symmetric(horizontal: 16),
                        tablet: EdgeInsets.zero,
                        desktop: EdgeInsets.zero,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Почему мы?",
                            style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w700,
                                fontSize: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 32,
                                  tablet: 40,
                                  desktop: 48,
                                ),
                                color: const Color(0xFF899ED4)),
                          ),
                          SizedBox(height: Responsive.getResponsiveValue(
                            context,
                            mobile: 38,
                            tablet: 48,
                            desktop: 56,
                          )),
                          if (isTablet || isDesktop)
                            _buildCardsGrid(context, cardsData)
                          else
                            Column(
                              children: List.generate(cardsData.length, (index) {
                                final card = cardsData[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == cardsData.length - 1
                                        ? 0
                                        : Responsive.getResponsiveValue(
                                            context,
                                            mobile: 38,
                                            tablet: 48,
                                            desktop: 56,
                                          ),
                                  ),
                                  child: _buildCardWidget(
                                    context: context,
                                    imagePath: card.imagePath,
                                    title: card.title,
                                  ),
                                );
                              }),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }

        return const SplashScreen();
      },
    );
  }

  Widget _buildCardsGrid(
      BuildContext context, List<_HomeCardData> cardsData) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
        crossAxisSpacing: Responsive.getResponsiveValue(
          context,
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
        mainAxisSpacing: Responsive.getResponsiveValue(
          context,
          mobile: 38,
          tablet: 48,
          desktop: 56,
        ),
        childAspectRatio: Responsive.isDesktop(context) ? 0.85 : 0.9,
      ),
      itemCount: cardsData.length,
      itemBuilder: (context, index) {
        final card = cardsData[index];
        return _buildCardWidget(
          context: context,
          imagePath: card.imagePath,
          title: card.title,
        );
      },
    );
  }

  Widget _buildCardWidget({
    required BuildContext context,
    required String imagePath,
    required String title,
  }) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              scale: Responsive.isTablet(context) ? 3 : 4,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image,
                    size: Responsive.getResponsiveValue(
                      context,
                      mobile: 40,
                      tablet: 60,
                      desktop: 80,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Responsive.getResponsiveValue(
            context,
            mobile: 12,
            tablet: 16,
            desktop: 20,
          )),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.getResponsiveValue(
                context,
                mobile: 20,
                tablet: 22,
                desktop: 24,
              ),
              fontWeight: FontWeight.w400,
              fontFamily: "SF Pro Display",
              color: const Color(0xFF4069D3),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCardData {
  final String imagePath;
  final String title;
  const _HomeCardData({required this.imagePath, required this.title});
}
