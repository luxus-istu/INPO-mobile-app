import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/error_message_widget.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';
import 'package:url_launcher2/url_launcher_string.dart';

class SpecialtyDetailPage extends StatefulWidget {
  const SpecialtyDetailPage({super.key});

  @override
  State<SpecialtyDetailPage> createState() => _SpecialtyDetailPageState();
}

class _SpecialtyDetailPageState extends State<SpecialtyDetailPage> {
  bool _showAllDisciplines = false;
  bool _showAllCompetencies = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyDetailBloc, SpecialtyDetailState>(
        bloc: getIt<SpecialtyDetailBloc>(),
        builder: (context, state) {
          if (state is SpecialtyDetailError) {
            return ErrorMessageWidget(error: state);
          }
          if (state is SpecialtyDetailLoaded) {
            final maxWidth = Responsive.getMaxContentWidth(context);
            
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ListView(
                    padding: Responsive.getResponsivePadding(
                      context,
                      mobile: const EdgeInsets.only(top: 57, left: 16, right: 16),
                      tablet: const EdgeInsets.only(top: 57, left: 32, right: 32),
                      desktop: const EdgeInsets.only(top: 57, left: 48, right: 48),
                    ),
                    children: [
                  HeaderWidget(
                    labelName: state.detail.title!,
                    onTap: () => context.pop(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              state.detail.icon!,
                              size: Responsive.getResponsiveValue(
                                context,
                                mobile: 80,
                                tablet: 100,
                                desktop: 120,
                              ),
                              color: const Color(0xFF4069D3),
                            ),
                            Text(
                              state.detail.duration!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 18,
                                  desktop: 20,
                                ),
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
                                fontSize: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 18,
                                  desktop: 20,
                                ),
                                fontFamily: "Onder",
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF000080),
                              ),
                            ),
                            Text(
                              state.detail.title!,
                              maxLines: Responsive.isTablet(context) ? 4 : 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontSize: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 18,
                                  desktop: 20,
                                ),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4069D3),
                              ),
                            ),
                            Text(
                              '${state.detail.seats!} мест',
                              style: TextStyle(
                                fontSize: Responsive.getResponsiveValue(
                                  context,
                                  mobile: 16,
                                  tablet: 18,
                                  desktop: 20,
                                ),
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
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 60,
                    tablet: 72,
                    desktop: 84,
                  )),
                  Text(
                    'ОПИСАНИЕ',
                    style: TextStyle(
                      fontSize: Responsive.getResponsiveValue(
                        context,
                        mobile: 15,
                        tablet: 18,
                        desktop: 20,
                      ),
                      fontFamily: "Onder",
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000080),
                    ),
                  ),
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 12,
                    tablet: 16,
                    desktop: 20,
                  )),
                  Container(
                    padding: Responsive.getResponsivePadding(
                      context,
                      mobile: const EdgeInsets.all(16),
                      tablet: const EdgeInsets.all(20),
                      desktop: const EdgeInsets.all(24),
                    ),
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
                        Text(
                          "В результате освоения программы обучения выпускник будет профессионально готов к следующим видам деятельности:",
                          style: TextStyle(
                            fontSize: Responsive.getResponsiveValue(
                              context,
                              mobile: 15,
                              tablet: 17,
                              desktop: 19,
                            ),
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF000080),
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveValue(
                          context,
                          mobile: 12,
                          tablet: 16,
                          desktop: 20,
                        )),
                        ...state.detail.competencies!
                            .take(_showAllCompetencies
                                ? state.detail.competencies!.length
                                : 3)
                            .map(
                              (item) => Text(
                                '• $item',
                                style: TextStyle(
                                  fontSize: Responsive.getResponsiveValue(
                                    context,
                                    mobile: 15,
                                    tablet: 17,
                                    desktop: 19,
                                  ),
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF4069D3),
                                ),
                              ),
                            ),
                        if (state.detail.competencies!.length >
                            3) // Показываем кнопку только если есть что скрывать
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
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 48,
                    tablet: 56,
                    desktop: 64,
                  )),
                  Text(
                    'ГИД ПО ДИСЦИПЛИНАМ',
                    style: TextStyle(
                      fontSize: Responsive.getResponsiveValue(
                        context,
                        mobile: 15,
                        tablet: 18,
                        desktop: 20,
                      ),
                      fontFamily: "Onder",
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000080),
                    ),
                  ),
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 18,
                    tablet: 24,
                    desktop: 28,
                  )),
                  Container(
                    padding: Responsive.getResponsivePadding(
                      context,
                      mobile: const EdgeInsets.all(16),
                      tablet: const EdgeInsets.all(20),
                      desktop: const EdgeInsets.all(24),
                    ),
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
                                  fontSize: Responsive.getResponsiveValue(
                                    context,
                                    mobile: 15,
                                    tablet: 17,
                                    desktop: 19,
                                  ),
                                  fontFamily: "SF Pro Display",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        if (state.detail.disciplines!.length >
                            3) // Показываем кнопку только если есть что скрывать
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
                      fontSize: Responsive.getResponsiveValue(
                        context,
                        mobile: 15,
                        tablet: 18,
                        desktop: 20,
                      ),
                      fontFamily: "Onder",
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000080),
                    ),
                  ),
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 16,
                    tablet: 20,
                    desktop: 24,
                  )),
                  ...state.detail.companies!.map(
                    (company) => Text(
                      company,
                      style: TextStyle(
                        fontSize: Responsive.getResponsiveValue(
                          context,
                          mobile: 15,
                          tablet: 17,
                          desktop: 19,
                        ),
                        color: const Color(0xFF000080),
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 60,
                    tablet: 72,
                    desktop: 84,
                  )),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await launchUrlString(state.detail.link!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9FBAFF),
                        foregroundColor: const Color(0xFF3A6BD9),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.getResponsiveValue(
                            context,
                            mobile: 30,
                            tablet: 40,
                            desktop: 50,
                          ),
                          vertical: Responsive.getResponsiveValue(
                            context,
                            mobile: 16,
                            tablet: 20,
                            desktop: 24,
                          ),
                        ),
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      child: Text(
                        'Поступить',
                        style: TextStyle(
                          fontSize: Responsive.getResponsiveValue(
                            context,
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.getResponsiveValue(
                    context,
                    mobile: 60,
                    tablet: 72,
                    desktop: 84,
                  )),
                    ],
                  ),
                ),
              ),
            );
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
}
