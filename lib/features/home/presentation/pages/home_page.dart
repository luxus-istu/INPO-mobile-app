import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_error_page.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_loading_page.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/news_card_widget.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  static const double _mobileExpandedHeight = 110;
  static const double _tabletExpandedHeight = 200;

  double get _expandedHeight {
    if (context.isTablet) return _tabletExpandedHeight;
    return _mobileExpandedHeight;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getIt<NewsBloc>().add(const FetchNews()));
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.sizeOf(context);

    return BlocBuilder<NewsBloc, NewsState>(
      bloc: getIt<NewsBloc>(),
      builder: (_, state) {
        if (state is NewsError) {
          return SplashErrorPage(state.message,
              retry: () => getIt<NewsBloc>().add(const FetchNews()));
        }
        if (state is NewsLoaded) {
          final news = state.news.take(5).toList();
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
                    labelName: AppLocalizations.of(context)!.universityName,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150, // ← здесь главная фиксация — задаём высоту
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: NewsCardWidget(news[index]),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => context.go("/chat"),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.aiWalkingMessage,
                            style: const TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 8,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Container(
                                width: sizes.width * .43,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Icon(
                                      Icons.forum_outlined,
                                      size: 30,
                                      color: const Color(0xff4069D3),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .askYourQuestion,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 12,
                                          color: Color(0xff454545),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 8,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Container(
                                width: sizes.width * .43,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Icon(
                                      Icons.history_outlined,
                                      size: 30,
                                      color: const Color(0xff4069D3),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.chatHistory,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 12,
                                          color: Color(0xff454545),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(colors: [
                        Color(0xffBABABA),
                        Color(0xffF5F5F5),
                      ]),
                    ),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Onder",
                                    height: 1.9,
                                    color: Color(0xff454545)),
                                children: [
                              TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .topSpecialtiesFrom),
                              TextSpan(
                                  text: AppLocalizations.of(context)!.ai,
                                  style: const TextStyle(
                                      color: Color(0xff4069D3))),
                              TextSpan(
                                  text: AppLocalizations.of(context)!.in2026)
                            ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: sizes.width * .4,
                          height: sizes.width * .4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.directorContacts,
                                style: const TextStyle(
                                  fontFamily: "SF Pro Display",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.phone_outlined,
                                size: 50,
                                color: Color(0xff4069D3),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 8,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              width: sizes.width * .45,
                              height: sizes.width * .2,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .financeDepartment,
                                    style: const TextStyle(
                                      fontFamily: "SF Pro Display",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.currency_ruble,
                                    size: 30,
                                    color: Color(0xff4069D3),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 8,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              width: sizes.width * .45,
                              height: sizes.width * .2,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.teachers,
                                    style: const TextStyle(
                                      fontFamily: "SF Pro Display",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.person_outline,
                                    size: 30,
                                    color: Color(0xff4069D3),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const SplashLoadingPage();
      },
    );
  }
}
