import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_event.dart';
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_state.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';
import 'package:inpo_mobile_app/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/presentation/pages/splash_screen.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                const HeaderWidget(labelName: "НОВОСТИ"),
                const SizedBox(height: 46),
                ...state.news.map((item) => NewsCard(newsItem: item))
              ],
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }

        return const SplashScreen();
      },
    );
  }
}
