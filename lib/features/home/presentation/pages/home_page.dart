import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_event.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_state.dart';
import 'package:inpo_mobile_app/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/image_collage_widget.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/splash_screen.dart';
import 'package:inpo_mobile_app/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          final imageUrls =
              state.news.map((newsItem) => newsItem.imageUrl ?? "").toList();

          return Scaffold(
            body: ListView(
              children: [
                const HeaderWidget(labelName: "ГЛАВНАЯ\nСТРАНИЦА"),
                ImageCollageWidget(imageUrls: imageUrls),
                Column(
                  children: [
                    const Text(
                      "Почему мы?",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Color(0xFF899ED4)),
                    ),
                    const SizedBox(height: 38),
                    _buildCardWidget(
                        imagePath: "assets/images/home_image_0.jpg",
                        title:
                            "Постоянное участие в\nмеждународных конкурсах и\nолимпиадах"),
                    const SizedBox(height: 38),
                    _buildCardWidget(
                        imagePath: "assets/images/home_image_1.jpg",
                        title: "Креативная студенческая\nжизнь"),
                    const SizedBox(height: 38),
                    _buildCardWidget(
                        imagePath: "assets/images/home_image_2.jpg",
                        title: "Большое разнообразие\nспециальностей"),
                  ],
                )
              ],
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
  }) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              scale: 4,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
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
