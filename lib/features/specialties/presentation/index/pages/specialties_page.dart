import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/bloc/specialty_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/widgets/specialty_grid_item.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';

final class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

final class _SpecialtiesPageState extends State<SpecialtiesPage> {
  static const double _expandedHeight = 160;
  static const double _collapseThreshold = _expandedHeight - kToolbarHeight;
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<SpecialtyBloc>().add(const FetchSpecialties());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyBloc, SpecialtyState>(
        bloc: getIt<SpecialtyBloc>(),
        builder: (context, state) {
          if (state is SpecialtyLoaded) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification) {
                    if (scrollNotification.metrics.pixels >=
                            _collapseThreshold &&
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
                child: CustomScrollView(
                  slivers: [
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
                          "ПРОФЕССИИ",
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
                        background: HeaderWidget(labelName: "ПРОФЕССИИ"),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          const EdgeInsets.only(bottom: 64, left: 8, right: 8),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.specialties.length,
                        itemBuilder: (context, index) {
                          final specialty = state.specialties[index];
                          return SpecialtyGridItem(specialty: specialty);
                        },
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: const AnimatedFabMenu(),
            );
          }
          return const SplashScreen();
        });
  }
}
