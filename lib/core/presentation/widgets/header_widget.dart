import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/utils/responsive_helper.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';

final class HeaderWidget extends StatelessWidget {
  final String labelName;
  final VoidCallback? onTap;
  const HeaderWidget({super.key, required this.labelName, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Get responsive values based on screen size
    final isTablet = context.isTablet;

    // Responsive font sizes
    final logoFontSize = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 48.0,
      tablet: 64.0,
      desktop: 72.0,
    );

    final labelFontSize = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );

    // Responsive padding
    final topPadding = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 78.0,
      tablet: 90.0,
      desktop: 100.0,
    );

    final backButtonSize = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 20.0,
      tablet: 24.0,
      desktop: 28.0,
    );

    final spacing = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );

    final bottomPadding = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: 28.0,
      tablet: 36.0,
      desktop: 44.0,
    );

    return Container(
      padding: EdgeInsets.only(top: topPadding),
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
              fontSize: logoFontSize,
              color: const Color(0xFF4069D3),
            ),
          ),
          SizedBox(height: spacing),
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
                    padding: EdgeInsets.zero,
                    minimumSize: Size(backButtonSize * 2, backButtonSize * 2),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: backButtonSize,
                  ),
                ),
              if (onTap != null)
                SizedBox(width: context.responsiveHorizontalPadding),
              Expanded(
                child: Text(
                  labelName,
                  textAlign: TextAlign.end,
                  maxLines: isTablet ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Onder",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    fontSize: labelFontSize,
                    color: const Color(0xFF4069D3),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
