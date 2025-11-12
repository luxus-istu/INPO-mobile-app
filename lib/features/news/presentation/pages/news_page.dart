import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

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
          final maxWidth = Responsive.getMaxContentWidth(context);
          final isTablet = Responsive.isTablet(context);
          final isDesktop = Responsive.isDesktop(context);
          
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: isTablet || isDesktop
                    ? Column(
                        children: [
                          const HeaderWidget(labelName: "НОВОСТИ"),
                          Expanded(
                            child: GridView.builder(
                              padding: Responsive.getResponsivePadding(
                                context,
                                mobile: EdgeInsets.zero,
                                tablet: const EdgeInsets.all(24),
                                desktop: const EdgeInsets.all(32),
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isDesktop ? 2 : 2,
                                crossAxisSpacing: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 24,
                                  desktop: 32,
                                ),
                                mainAxisSpacing: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 24,
                                  desktop: 32,
                                ),
                                childAspectRatio: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 1.0,
                                  tablet: 1.2,
                                  desktop: 1.3,
                                ),
                              ),
                              itemCount: state.news.length,
                              itemBuilder: (context, index) {
                                return NewsCard(newsItem: state.news[index]);
                              },
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        children: [
                          const HeaderWidget(labelName: "НОВОСТИ"),
                          SizedBox(height: Responsive.getResponsiveValue(
                            context,
                            mobile: 46,
                            tablet: 56,
                            desktop: 64,
                          )),
                          ...state.news.map((item) => NewsCard(newsItem: item))
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
}
