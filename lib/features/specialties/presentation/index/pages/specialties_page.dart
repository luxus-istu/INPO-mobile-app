import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/bloc/specialty_bloc.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/index/widgets/specialty_grid_item.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/responsive_helper.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/pages/splash_screen.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

final class _SpecialtiesPageState extends State<SpecialtiesPage> {
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
      getIt<SpecialtyBloc>().add(const FetchSpecialties());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get responsive values
    final isTablet = context.isTablet;

    // Responsive grid columns
    final crossAxisCount = ResponsiveHelper.responsiveGridColumns(
      context: context,
      mobile: 2,
      tablet: 3,
    );

    // Responsive spacing
    final spacing = ResponsiveHelper.responsiveSpacing(
      context: context,
      mobile: 8.0,
      tablet: 12.0,
    );

    // Responsive aspect ratio
    final aspectRatio = ResponsiveHelper.responsiveAspectRatio(
      context: context,
      mobile: 0.7,
      tablet: 0.8,
    );

    // Responsive font size for title
    final titleFontSize = ResponsiveHelper.responsiveFontSize(
      context: context,
      mobile: 16.0,
      tablet: 18.0,
    );

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
                        child: Text(
                          AppLocalizations.of(context)!.specialtiesHeader,
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
                      flexibleSpace: FlexibleSpaceBar(
                        background: HeaderWidget(
                            labelName: AppLocalizations.of(context)!
                                .specialtiesHeader),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: ResponsiveHelper.responsiveValue<double>(
                          context: context,
                          mobile: 64.0,
                          tablet: 80.0,
                        ),
                        left: spacing,
                        right: spacing,
                      ),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: aspectRatio,
                        ),
                        itemCount: state.specialties.length,
                        itemBuilder: (context, index) {
                          final specialty = state.specialties[index];
                          return SpecialtyGridItem(
                            specialty: specialty,
                            isTablet: isTablet,
                          );
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
