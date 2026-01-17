import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';

class SpecialtyInfoCard extends StatelessWidget {
  final SpecialtyDetail detail;
  final bool showAllCompetencies;
  final VoidCallback onToggleCompetencies;
  final bool showAllDisciplines;
  final VoidCallback onToggleDisciplines;

  const SpecialtyInfoCard({
    super.key,
    required this.detail,
    required this.showAllCompetencies,
    required this.onToggleCompetencies,
    required this.showAllDisciplines,
    required this.onToggleDisciplines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('ОПИСАНИЕ'),
        const SizedBox(height: 12),
        _buildDescriptionCard(),
        const SizedBox(height: 48),
        _buildSectionHeader('ГИД ПО ДИСЦИПЛИНАМ'),
        const SizedBox(height: 18),
        _buildDisciplinesSection(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontFamily: "Onder",
        fontWeight: FontWeight.w400,
        color: Color(0xFF000080),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
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
          ..._buildCompetencyItems(),
          if (detail.competencies!.length > 3)
            _buildToggleButton(
              showAllCompetencies ? 'Скрыть' : 'Подробнее',
              onToggleCompetencies,
            ),
        ],
      ),
    );
  }

  List<Widget> _buildCompetencyItems() {
    return detail.competencies!
        .take(showAllCompetencies ? detail.competencies!.length : 3)
        .map(
          (item) => Text(
            '• $item',
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.bold,
              color: Color(0xFF4069D3),
            ),
          ),
        )
        .toList();
  }

  Widget _buildDisciplinesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildDisciplineItems(),
          if (detail.disciplines!.length > 3)
            _buildToggleButton(
              showAllDisciplines ? 'Скрыть' : 'Подробнее',
              onToggleDisciplines,
            ),
        ],
      ),
    );
  }

  List<Widget> _buildDisciplineItems() {
    return detail.disciplines!
        .take(showAllDisciplines ? detail.disciplines!.length : 5)
        .map(
          (item) => Text(
            '• $item',
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )
        .toList();
  }

  Widget _buildToggleButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF000080),
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            text == 'Скрыть' ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            size: 24,
            color: const Color(0xFF000080),
          )
        ],
      ),
    );
  }
}
