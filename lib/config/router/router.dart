import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:inpo_mobile_app/features/home/presentation/pages/home_page.dart';
import 'package:inpo_mobile_app/features/news/presentation/pages/news_page.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/pages/specialties_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/features/specialty_detail/presentation/bloc/specialty_detail_bloc.dart';
import 'package:inpo_mobile_app/features/specialty_detail/presentation/bloc/specialty_detail_event.dart';
import 'package:inpo_mobile_app/features/specialty_detail/presentation/pages/specialty_detail_page.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (_, __) => const HomePage()),
  GoRoute(path: "/specialties", builder: (_, __) => const SpecialtiesPage()),
  GoRoute(
    path: '/specialty_detail',
    builder: (context, state) {
      final url = state.extra as String?;

      if (url == null) {
        return const Scaffold(
            body: Center(child: Text('Ошибка: URL не найден')));
      }
      return BlocProvider.value(
        value: getIt<SpecialtyDetailBloc>()..add(FetchSpecialtyDetail(url)),
        child: const SpecialtyDetailPage(),
      );
    },
  ),
  GoRoute(path: "/news", builder: (_, __) => const NewsPage()),
  GoRoute(path: "/contacts", builder: (_, __) => const ContactsPage()),
]);
