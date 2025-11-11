import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/bloc/specialty_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/widgets/specialty_grid_item.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getIt<SpecialtyBloc>().add(const FetchSpecialties());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SpecialtyBloc, SpecialtyState>(
      bloc: getIt<SpecialtyBloc>(),
      builder: (context, state) {
        if (state is SpecialtyLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 220,
              title: const SizedBox.shrink(),
              flexibleSpace: const HeaderWidget(labelName: "ПРОФЕССИИ"),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.only(bottom: 64, left: 8, right: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: .7,
              ),
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
