import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class SpecialtyGridItem extends StatelessWidget {
  final Specialty specialty;
  final bool isTablet;
  final bool isDesktop;

  const SpecialtyGridItem({
    super.key,
    required this.specialty,
    this.isTablet = false,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final iconSize = isDesktop
        ? 64.0
        : isTablet
            ? 56.0
            : 48.0;
    final fontSize = isDesktop
        ? 18.0
        : isTablet
            ? 17.0
            : 16.0;
    final padding = isDesktop
        ? 12.0
        : isTablet
            ? 10.0
            : 8.0;
    final topSpacing = isDesktop
        ? 40.0
        : isTablet
            ? 36.0
            : 32.0;
    final middleSpacing = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;

    return GestureDetector(
      onTap: () {
        context.push('/specialties/details', extra: specialty.link);
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        color: Color(0xFF9FBAFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: topSpacing),
            Icon(
              specialty.icon,
              size: iconSize,
              color: Colors.white,
            ),
            SizedBox(height: middleSpacing),
            Text(
              specialty.title!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "SF Pro Display",
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
