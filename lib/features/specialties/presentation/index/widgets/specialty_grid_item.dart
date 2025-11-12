import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecialtyGridItem extends StatelessWidget {
  final Specialty specialty;

  const SpecialtyGridItem({
    super.key,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/specialties/details', extra: specialty.link);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Color(0xFF9FBAFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Icon(
              specialty.icon,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              specialty.title!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "SF Pro Display",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
