import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/features/news/presentation/widgets/news_card.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

final class _NewsPageState extends State<NewsPage> {
  static const double _mobileExpandedHeight = 110;
  static const double _tabletExpandedHeight = 200;

  // ← Добавляем состояние выбранной категории
  String? _selectedCategory;

  // Пример списка тем (можно вынести в константы / локализацию / из BLoC)
  static const List<Map<String, String>> _categories = [
    {'label': 'Все', 'value': ""}, // null = без фильтра
    {'label': 'Жизнь университета', 'value': 'zhizn-universiteta'},
    {'label': 'Культура и спорт', 'value': 'kultura-i-sport'},
    {'label': 'Образование', 'value': 'obrazovanie'},
    {'label': 'Наука', 'value': 'nauka'},
    {'label': 'Карьера', 'value': 'karera'},
    {'label': 'Для абитуриента', 'value': 'abiturient'},
    {'label': 'Другое', 'value': 'drugoe'},
  ];

  double get _expandedHeight =>
      context.isTablet ? _tabletExpandedHeight : _mobileExpandedHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<NewsBloc>()
          .add(const FetchNews()); // начальная загрузка — все новости
      _selectedCategory = _categories.first['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: _expandedHeight,
          pinned: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.black26,
          flexibleSpace: FlexibleSpaceBar(
            background: HeaderWidget(
              labelName: AppLocalizations.of(context)!.newsHeader,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 48,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat['value'];

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(
                      cat['label']!,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF4069D3),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = cat['value'];
                      });
                      getIt<NewsBloc>().add(
                        FetchNews(newsType: _selectedCategory ?? ""),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        BlocBuilder<NewsBloc, NewsState>(
            bloc: getIt<NewsBloc>(),
            builder: (context, state) {
              if (state is NewsLoaded) {
                if (isTablet) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 16,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // ← было 1, если хочешь 2 — поменяй
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        return NewsCard(
                          newsItem: state.news[index],
                          isTablet: isTablet,
                        );
                      },
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => NewsCard(
                        newsItem: state.news[index],
                        isTablet: isTablet,
                      ),
                      childCount: state.news.length,
                    ),
                  );
                }
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xff4069D3)),
                ),
              );
            }),
      ],
    );

    // return BlocBuilder<NewsBloc, NewsState>(
    //   bloc: getIt<NewsBloc>(),
    //   builder: (context, state) {
    //     if (state is NewsLoaded) {
    //       return CustomScrollView(
    //         slivers: [
    //           SliverAppBar(
    //             expandedHeight: _expandedHeight,
    //             pinned: true,
    //             surfaceTintColor: Colors.white,
    //             backgroundColor: Colors.white,
    //             shadowColor: Colors.black26,
    //             flexibleSpace: FlexibleSpaceBar(
    //               background: HeaderWidget(
    //                 labelName: AppLocalizations.of(context)!.newsHeader,
    //               ),
    //             ),
    //           ),
    //           SliverToBoxAdapter(
    //             child: Container(
    //               height: 48,
    //               margin: const EdgeInsets.only(bottom: 8),
    //               child: ListView.builder(
    //                 padding: EdgeInsets.symmetric(
    //                   horizontal: context.responsiveHorizontalPadding,
    //                   vertical: 8,
    //                 ),
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: _categories.length,
    //                 itemBuilder: (context, index) {
    //                   final cat = _categories[index];
    //                   final isSelected = _selectedCategory == cat['value'];

    //                   return Padding(
    //                     padding: const EdgeInsets.only(right: 12),
    //                     child: ChoiceChip(
    //                       label: Text(
    //                         cat['label']!,
    //                         style: TextStyle(
    //                           color: isSelected ? Colors.white : Colors.black87,
    //                           fontWeight: isSelected
    //                               ? FontWeight.w600
    //                               : FontWeight.w400,
    //                         ),
    //                       ),
    //                       selected: isSelected,
    //                       selectedColor: const Color(0xFF4069D3),
    //                       backgroundColor: Colors.grey.shade200,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20),
    //                       ),
    //                       onSelected: (_) {
    //                         setState(() {
    //                           _selectedCategory = cat['value'];
    //                         });
    //                         getIt<NewsBloc>().add(
    //                           FetchNews(newsType: _selectedCategory ?? ""),
    //                         );
    //                       },
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //           if (isTablet)
    //             SliverPadding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: context.responsiveHorizontalPadding,
    //                 vertical: 16,
    //               ),
    //               sliver: SliverGrid.builder(
    //                 gridDelegate:
    //                     const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 1, // ← было 1, если хочешь 2 — поменяй
    //                   crossAxisSpacing: 16,
    //                   mainAxisSpacing: 16,
    //                   childAspectRatio: 0.8,
    //                 ),
    //                 itemCount: state.news.length,
    //                 itemBuilder: (context, index) {
    //                   return NewsCard(
    //                     newsItem: state.news[index],
    //                     isTablet: isTablet,
    //                   );
    //                 },
    //               ),
    //             )
    //           else
    //             SliverList(
    //               delegate: SliverChildBuilderDelegate(
    //                 (context, index) => NewsCard(
    //                   newsItem: state.news[index],
    //                   isTablet: isTablet,
    //                 ),
    //                 childCount: state.news.length,
    //               ),
    //             ),
    //         ],
    //       );
    //     }

    //     return const SplashLoadingPage();
    //   },
    // );
  }
}
