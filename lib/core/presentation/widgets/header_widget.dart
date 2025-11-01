import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
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
          const Text('ИНПО',
              style: TextStyle(
                  fontFamily: "Onder",
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                  fontSize: 48,
                  color: Color(0xFF4069D3))),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: this.onTap != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            spacing: 32,
            children: [
              if (this.onTap != null)
                ElevatedButton(
                    onPressed: this.onTap,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    )),
              Expanded(
                child: Text(this.labelName,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "Onder",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF4069D3))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
