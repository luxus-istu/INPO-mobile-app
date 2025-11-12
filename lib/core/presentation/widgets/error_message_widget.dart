import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart';

class ErrorMessageWidget extends StatelessWidget {
  final SpecialtyDetailError error;
  const ErrorMessageWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final errorCode =
        (error.error as DioException).response?.statusCode.toString() ?? "500";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(labelName: "ОШИБКА"),
          const SizedBox(height: 160),
          Text(
            errorCode,
            style: TextStyle(
                fontFamily: "Onder",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                fontSize: 40,
                color: Color(0xFF4069D3)),
          ),
          const SizedBox(height: 24),
          const Text(
            "Что то пошло\nне так...",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Onder",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF000080)),
          ),
          const SizedBox(height: 24),
          const Text(
            "Сервер лежит и прохлаждается,но\nскоро все уладится ;)",
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
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, size: 24, color: Color(0xff000080)),
                  SizedBox(width: 16),
                  Text(
                    "Вернуться",
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
