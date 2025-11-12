import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';

class HeaderWidget extends StatelessWidget {
  final String labelName;
  final VoidCallback? onTap;
  const HeaderWidget({super.key, required this.labelName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Responsive.getResponsiveValue(
          context,
          mobile: 78,
          tablet: 90,
          desktop: 100,
        ),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ИНПО',
            style: TextStyle(
              fontFamily: "Onder",
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              fontSize: Responsive.getResponsiveValue(
                context,
                mobile: 48,
                tablet: 64,
                desktop: 80,
              ),
              color: const Color(0xFF4069D3),
            ),
          ),
          SizedBox(
              height: Responsive.getResponsiveValue(
            context,
            mobile: 12,
            tablet: 16,
            desktop: 20,
          )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: this.onTap != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            spacing: Responsive.getResponsiveValue(
              context,
              mobile: 32,
              tablet: 40,
              desktop: 48,
            ),
            children: [
              if (this.onTap != null)
                ElevatedButton(
                  onPressed: this.onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: Responsive.getResponsiveValue(
                      context,
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                  this.labelName,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Onder",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.getResponsiveValue(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 24,
                    ),
                    color: const Color(0xFF4069D3),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: Responsive.getResponsiveValue(
            context,
            mobile: 28,
            tablet: 40,
            desktop: 52,
          )),
        ],
      ),
    );
  }
}
