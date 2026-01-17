import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

class SpecialtyHeader extends StatelessWidget {
  final SpecialtyDetail detail;

  const SpecialtyHeader({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                detail.icon!,
                size: 80,
                color: const Color(0xFF4069D3),
              ),
              Text(
                detail.duration!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F8F8F),
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
                detail.code!,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Onder",
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000080),
                ),
              ),
              Text(
                detail.title!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4069D3),
                ),
              ),
              Text(
                '${detail.seats!} ${AppLocalizations.of(context)!.seats}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SF Pro Display",
                  color: Color(0xFF8F8F8F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
