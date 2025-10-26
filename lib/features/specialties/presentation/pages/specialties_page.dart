import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/home/presentation/widgets/splash_screen.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_event.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_state.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/widgets/specialty_grid_item.dart';
import 'package:inpo_mobile_app/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage> {
  @override
  void initState() {
    super.initState();
    getIt<SpecialtyBloc>().add(const FetchSpecialties());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyBloc, SpecialtyState>(
      bloc: getIt<SpecialtyBloc>(),
      builder: (context, state) {
        if (state is SpecialtyLoaded) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 158,
              title: const SizedBox.shrink(),
              flexibleSpace: const HeaderWidget(labelName: "ПРОФЕССИИ"),
            ),
            body: GridView.builder(
              padding:
                  const EdgeInsets.only(bottom: 62, top: 62, right: 8, left: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Количество колонок
                  crossAxisSpacing: 8, // Горизонтальный отступ
                  mainAxisSpacing: 8, // Вертикальный отступ
                  childAspectRatio: .7),
              itemCount: state.specialties.length,
              itemBuilder: (context, index) {
                final specialty = state.specialties[index];
                return SpecialtyGridItem(specialty: specialty);
              },
            ),
            floatingActionButton: const AnimatedFabMenu(),
          );
        }
        return const SplashScreen();
      },
    );
  }
}
