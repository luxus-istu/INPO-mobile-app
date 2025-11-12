import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/bloc/specialty_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/widgets/specialty_grid_item.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

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
          final maxWidth = Responsive.getMaxContentWidth(context);
          final crossAxisCount = Responsive.getGridCrossAxisCount(context);
          
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: Responsive.getResponsiveValue(
                context,
                mobile: 220,
                tablet: 240,
                desktop: 260,
              ),
              title: const SizedBox.shrink(),
              flexibleSpace: const HeaderWidget(labelName: "ПРОФЕССИИ"),
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              shadowColor: Colors.white,
              animateColor: false,
              surfaceTintColor: Colors.white,
              elevation: 0,
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: GridView.builder(
                  padding: Responsive.getResponsivePadding(
                    context,
                    mobile: const EdgeInsets.only(bottom: 64, left: 8, right: 8),
                    tablet: const EdgeInsets.only(bottom: 64, left: 16, right: 16),
                    desktop: const EdgeInsets.only(bottom: 64, left: 24, right: 24),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: Responsive.getResponsiveValue(
                      context,
                      mobile: 8,
                      tablet: 12,
                      desktop: 16,
                    ),
                    mainAxisSpacing: Responsive.getResponsiveValue(
                      context,
                      mobile: 8,
                      tablet: 12,
                      desktop: 16,
                    ),
                    childAspectRatio: Responsive.getResponsiveValue(
                      context,
                      mobile: 0.7,
                      tablet: 0.75,
                      desktop: 0.8,
                    ),
                  ),
                  itemCount: state.specialties.length,
                  itemBuilder: (context, index) {
                    final specialty = state.specialties[index];
                    return SpecialtyGridItem(specialty: specialty);
                  },
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
