import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_loading_page.dart';

final class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

final class _NewsPageState extends State<NewsPage> {
  static const double _mobileExpandedHeight = 160;
  static const double _tabletExpandedHeight = 200;
  bool _isAppBarCollapsed = false;

  double get _expandedHeight {
    if (context.isTablet) return _tabletExpandedHeight;
    return _mobileExpandedHeight;
  }

  double get _collapseThreshold => _expandedHeight - kToolbarHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<NewsBloc>().add(const FetchNews());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final isTablet = context.isTablet;

    // Responsive font size for title
    final titleFontSize = isTablet ? 18.0 : 16.0;

    // Determine layout type
    final useGridLayout = isTablet;
    final crossAxisCount = 1;

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
                    child: Text(
                      AppLocalizations.of(context)!.newsHeader,
                      style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: titleFontSize,
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
                if (useGridLayout)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 16,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final item = state.news[index];
                        return NewsCard(
                          newsItem: item,
                          isTablet: isTablet,
                        );
                      },
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildListDelegate([
                      ...state.news.map((item) => NewsCard(
                            newsItem: item,
                            isTablet: isTablet,
                          ))
                    ]),
                  ),
              ]),
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }

        return const SplashLoadingPage();
      },
    );
  }
}
