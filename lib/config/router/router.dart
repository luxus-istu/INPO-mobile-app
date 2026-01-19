import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/pages/bottom_navigation_bar_base_page.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_error_page.dart';
import 'package:inpo_mobile_app/features/chat/presentation/pages/chat_bot_page.dart';
import 'package:inpo_mobile_app/features/home/presentation/pages/home_page.dart';
import 'package:inpo_mobile_app/features/news/presentation/pages/news_page.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/pages/specialty_detail_page.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/pages/specialties_page.dart';

final GoRouter router = GoRouter(
    errorBuilder: (context, state) => SplashErrorPage(
          state.error!,
          retry: () => context.go('/'),
          buttonMessage: "Go home",
        ),
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) =>
              BottomNavigationBarBasePage(navigationShell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: '/', builder: (_, __) => const HomePage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: "/specialties",
                  builder: (_, __) => const SpecialtiesPage(),
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (context, state) {
                        final url = state.extra as String?;

                        if (url == null) {
                          return Scaffold(
                              body: Center(
                                  child: Builder(
                            builder: (context) =>
                                Text(AppLocalizations.of(context)!.urlNotFound),
                          )));
                        }
                        return BlocProvider.value(
                          value: getIt<SpecialtyDetailBloc>()
                            ..add(FetchSpecialtyDetail(url)),
                          child: const SpecialtyDetailPage(),
                        );
                      },
                    ),
                  ])
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: '/chat',
                  builder: (context, state) => const ChatBotPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: "/news", builder: (_, __) => const NewsPage()),
            ]),
          ]),
    ]);
