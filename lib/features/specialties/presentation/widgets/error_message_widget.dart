import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_detail_state.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String route;
  final SpecialtyDetailError error;
  const ErrorMessageWidget(
      {super.key, required this.route, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.only(top: 57, left: 16, right: 16),
          children: [
            HeaderWidget(
              labelName: "ОШИБКА",
              onTap: () => context.go(this.route),
            ),
            const SizedBox(height: 100),
            Text(
              this.error.message,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}
