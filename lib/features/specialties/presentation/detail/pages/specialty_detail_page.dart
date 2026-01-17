import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/error_message_widget.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SpecialtyDetailPage extends StatefulWidget {
  const SpecialtyDetailPage({super.key});

  @override
  State<SpecialtyDetailPage> createState() => _SpecialtyDetailPageState();
}

class _SpecialtyDetailPageState extends State<SpecialtyDetailPage> {
  static const double _mobileExpandedHeight = 184;
  static const double _tabletExpandedHeight = 220;
  static const double _desktopExpandedHeight = 260;
  bool _isAppBarCollapsed = false;
  bool _showAllDisciplines = false;
  bool _showAllCompetencies = false;

  double get _expandedHeight {
    if (context.isLargeScreen) return _desktopExpandedHeight;
    if (context.isTablet) return _tabletExpandedHeight;
    return _mobileExpandedHeight;
  }

  double get _collapseThreshold => _expandedHeight - kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyDetailBloc, SpecialtyDetailState>(
        bloc: getIt<SpecialtyDetailBloc>(),
        builder: (context, state) {
          if (state is SpecialtyDetailError) {
            return ErrorMessageWidget(error: state);
          }
          if (state is SpecialtyDetailLoaded) {
            // Determine if we should use tablet/desktop layout
            final isTabletOrDesktop = context.isTablet || context.isLargeScreen;

            if (isTabletOrDesktop) {
              return _buildTabletDesktopLayout(state);
            } else {
              return _buildMobileLayout(state);
            }
          }
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: CircularProgressIndicator(
              color: Color(0xFF4069D3),
            )),
          );
        });
  }

  Widget _buildMobileLayout(SpecialtyDetailLoaded state) {
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
            } else if (scrollNotification.metrics.pixels < _collapseThreshold &&
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
                  state.detail.title!,
                  style: TextStyle(
                    fontFamily: "Onder",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xFF4069D3),
                  ),
                ),
              ),
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                background: HeaderWidget(
                  labelName: state.detail.title!,
                  onTap: () => context.pop(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            state.detail.icon!,
                            size: 80,
                            color: const Color(0xFF4069D3),
                          ),
                          Text(
                            state.detail.duration!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8F8F8F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            state.detail.code!,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Onder",
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF000080),
                            ),
                          ),
                          Text(
                            state.detail.title!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4069D3),
                            ),
                          ),
                          Text(
                            '${state.detail.seats!} мест',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SF Pro Display",
                              color: const Color(0xFF8F8F8F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Text(
                  'ОПИСАНИЕ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Onder",
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000080),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 16,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "В результате освоения программы обучения выпускник будет профессионально готов к следующим видам деятельности:",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000080),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...state.detail.competencies!
                          .take(_showAllCompetencies
                              ? state.detail.competencies!.length
                              : 3)
                          .map(
                            (item) => Text(
                              '• $item',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4069D3),
                              ),
                            ),
                          ),
                      if (state.detail.competencies!.length > 3)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showAllCompetencies = !_showAllCompetencies;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _showAllCompetencies ? 'Скрыть' : 'Подробнее',
                                style: const TextStyle(
                                  color: const Color(0xFF000080),
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                _showAllCompetencies
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 24,
                                color: const Color(0xFF000080),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'ГИД ПО ДИСЦИПЛИНАМ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Onder",
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000080),
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...state.detail.disciplines!
                          .take(_showAllDisciplines
                              ? state.detail.disciplines!.length
                              : 5)
                          .map(
                            (item) => Text(
                              '• $item',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      if (state.detail.disciplines!.length > 3)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showAllDisciplines = !_showAllDisciplines;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _showAllDisciplines ? 'Скрыть' : 'Подробнее',
                                style: const TextStyle(
                                  color: Color(0xFF000080),
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                _showAllDisciplines
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_drop_up,
                                size: 24,
                                color: const Color(0xFF000080),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Text(
                  'ГДЕ ВОЗЬМУТ НА РАБОТУ И ПРАКТИКУ?',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Onder",
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000080),
                  ),
                ),
                SizedBox(height: 16),
                ...state.detail.companies!.map(
                  (company) => Text(
                    company,
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color(0xFF000080),
                      fontFamily: "SF Pro Display",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: ElevatedButton(
                    onPressed: () async =>
                        await launchUrlString(state.detail.link!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9FBAFF),
                      foregroundColor: const Color(0xFF3A6BD9),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 16,
                      ),
                      elevation: 8,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    child: Text(
                      'Поступить',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ])),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletDesktopLayout(SpecialtyDetailLoaded state) {
    // Responsive sizing for tablet/desktop
    final isDesktop = context.isLargeScreen;
    final iconSize = isDesktop ? 120.0 : 100.0;
    final titleFontSize = isDesktop ? 24.0 : 20.0;
    final subtitleFontSize = isDesktop ? 20.0 : 18.0;
    final spacing = isDesktop ? 24.0 : 20.0;
    final horizontalPadding = isDesktop ? 32.0 : 24.0;
    final buttonFontSize = isDesktop ? 24.0 : 22.0;
    final buttonPadding = isDesktop ? 40.0 : 30.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black26,
        title: Text(
          state.detail.title!,
          style: TextStyle(
            fontFamily: "Onder",
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w400,
            fontSize: titleFontSize,
            color: const Color(0xFF4069D3),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacing),
              // Two-column header info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          state.detail.icon!,
                          size: iconSize,
                          color: const Color(0xFF4069D3),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          state.detail.duration!,
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF8F8F8F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spacing * 2),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.detail.code!,
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: "Onder",
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000080),
                          ),
                        ),
                        Text(
                          state.detail.title!,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4069D3),
                          ),
                        ),
                        Text(
                          '${state.detail.seats!} мест',
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SF Pro Display",
                            color: const Color(0xFF8F8F8F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 2),
              // Two-column main content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - Description and Competencies
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ОПИСАНИЕ',
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: "Onder",
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000080),
                          ),
                        ),
                        SizedBox(height: spacing),
                        Container(
                          padding: EdgeInsets.all(spacing),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 16,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "В результате освоения программы обучения выпускник будет профессионально готов к следующим видам деятельности:",
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF000080),
                                ),
                              ),
                              SizedBox(height: spacing),
                              ...state.detail.competencies!
                                  .take(_showAllCompetencies
                                      ? state.detail.competencies!.length
                                      : 5)
                                  .map(
                                    (item) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: spacing * 0.5),
                                      child: Text(
                                        '• $item',
                                        style: TextStyle(
                                          fontSize: subtitleFontSize,
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF4069D3),
                                        ),
                                      ),
                                    ),
                                  ),
                              if (state.detail.competencies!.length > 5)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAllCompetencies =
                                          !_showAllCompetencies;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _showAllCompetencies
                                            ? 'Скрыть'
                                            : 'Подробнее',
                                        style: TextStyle(
                                          color: const Color(0xFF000080),
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.bold,
                                          fontSize: subtitleFontSize,
                                        ),
                                      ),
                                      Icon(
                                        _showAllCompetencies
                                            ? Icons.arrow_drop_down
                                            : Icons.arrow_drop_up,
                                        size: 30,
                                        color: const Color(0xFF000080),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spacing * 2),
                  // Right column - Disciplines and Companies
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ГИД ПО ДИСЦИПЛИНАМ',
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: "Onder",
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000080),
                          ),
                        ),
                        SizedBox(height: spacing),
                        Container(
                          padding: EdgeInsets.all(spacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...state.detail.disciplines!
                                  .take(_showAllDisciplines
                                      ? state.detail.disciplines!.length
                                      : 10)
                                  .map(
                                    (item) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: spacing * 0.3),
                                      child: Text(
                                        '• $item',
                                        style: TextStyle(
                                          fontSize: subtitleFontSize,
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                              if (state.detail.disciplines!.length > 10)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAllDisciplines =
                                          !_showAllDisciplines;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _showAllDisciplines
                                            ? 'Скрыть'
                                            : 'Подробнее',
                                        style: TextStyle(
                                          color: Color(0xFF000080),
                                          fontFamily: "SF Pro Display",
                                          fontWeight: FontWeight.bold,
                                          fontSize: subtitleFontSize,
                                        ),
                                      ),
                                      Icon(
                                        _showAllDisciplines
                                            ? Icons.arrow_drop_down
                                            : Icons.arrow_drop_up,
                                        size: 30,
                                        color: const Color(0xFF000080),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          'ГДЕ ВОЗЬМУТ НА РАБОТУ И ПРАКТИКУ?',
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: "Onder",
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000080),
                          ),
                        ),
                        SizedBox(height: spacing),
                        ...state.detail.companies!.map(
                          (company) => Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: spacing * 0.3),
                            child: Text(
                              company,
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: const Color(0xFF000080),
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 2),
              Center(
                child: ElevatedButton(
                  onPressed: () async =>
                      await launchUrlString(state.detail.link!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9FBAFF),
                    foregroundColor: const Color(0xFF3A6BD9),
                    padding: EdgeInsets.symmetric(
                      horizontal: buttonPadding,
                      vertical: 18,
                    ),
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  child: Text(
                    'Поступить',
                    style: TextStyle(
                      fontSize: buttonFontSize,
                      fontFamily: "SF Pro Display",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}
