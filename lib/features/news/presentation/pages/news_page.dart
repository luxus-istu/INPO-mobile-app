import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

final class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

final class _NewsPageState extends State<NewsPage> {
  static const double _expandedHeight = 160;
  static const double _collapseThreshold = _expandedHeight - kToolbarHeight;
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<NewsBloc>().add(const FetchNews());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: getIt<NewsBloc>(),
      builder: (context, state) {
        if (state is NewsLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  if (scrollNotification.metrics.pixels >= _collapseThreshold &&
                      !_isAppBarCollapsed) {
                    setState(() {
                      _isAppBarCollapsed = true;
                    });
                  } else if (scrollNotification.metrics.pixels <
                          _collapseThreshold &&
                      _isAppBarCollapsed) {
                    setState(() {
                      _isAppBarCollapsed = false;
                    });
                  }
                }
                return false;
              },
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  expandedHeight: _expandedHeight,
                  pinned: true,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black26,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: _isAppBarCollapsed ? 1.0 : 0.0,
                    child: const Text(
                      "НОВОСТИ",
                      style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF4069D3),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: HeaderWidget(
                      labelName: "НОВОСТИ",
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  ...state.news.map((item) => NewsCard(newsItem: item))
                ])),
              ]),
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }

        return const SplashScreen();
      },
    );
  }
}
