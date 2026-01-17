import 'package:flutter/material.dart';

final class HeaderWidget extends StatelessWidget {
  final String labelName;
  final VoidCallback? onTap;
  const HeaderWidget({super.key, required this.labelName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 78),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ИНПО',
            style: TextStyle(
              fontFamily: "Onder",
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              fontSize: 48,
              color: Color(0xFF4069D3),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: onTap != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (onTap != null)
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              const SizedBox(width: 32),
              Expanded(
                child: Text(
                  labelName,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Onder",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF4069D3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
