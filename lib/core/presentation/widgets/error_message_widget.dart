import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class ErrorMessageWidget extends StatelessWidget {
  final SpecialtyDetailError error;
  const ErrorMessageWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Icon(Icons.arrow_back, size: 24, color: Color(0xff000080)),
          const SizedBox(width: 16),
          Text(
            AppLocalizations.of(context)!.goBack,
            style: TextStyle(
                fontFamily: "Onder",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                fontSize: 40,
                color: Color(0xFF4069D3)),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.somethingWentWrong,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Onder",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000080)),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.serverMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w400,
              color: Color(0xff000080),
            ),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Color(0xffF8F8F8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Color(0x0f000000),
                      offset: Offset(0, 2),
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back,
                      size: 24, color: Color(0xff000080)),
                  SizedBox(width: 16),
                  Text(
                    AppLocalizations.of(context)!.goBack,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000080)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
