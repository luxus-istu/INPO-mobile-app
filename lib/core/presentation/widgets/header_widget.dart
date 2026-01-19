import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/utils/responsive_helper.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class HeaderWidget extends StatelessWidget {
  final String labelName;
  final VoidCallback? onTap;
  const HeaderWidget({super.key, required this.labelName, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Get responsive values based on screen size
    final isTablet = context.isTablet;

    // Responsive padding
    final backButtonSize = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: context.screenWidth < 360 ? 18.0 : 20.0,
      tablet: context.screenWidth < 700 ? 22.0 : 24.0,
    );

    final spacing = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: context.screenHeight < 700 ? 8.0 : 12.0,
      tablet: context.screenHeight < 900 ? 12.0 : 16.0,
    );

    final bottomPadding = ResponsiveHelper.responsiveValue<double>(
      context: context,
      mobile: context.screenHeight < 700 ? 20.0 : 28.0,
      tablet: context.screenHeight < 900 ? 28.0 : 36.0,
    );

    return SafeArea(
      child: Container(
          color: Colors.white,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: context.screenHeight * 0.2,
              maxHeight: context.screenHeight * 0.3,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.brandName,
                    style: TextStyle(
                      fontFamily: "Onder",
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
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
                            minimumSize:
                                Size(backButtonSize * 2, backButtonSize * 2),
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            labelName,
                            textAlign: TextAlign.end,
                            maxLines: isTablet ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "Onder",
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              fontSize: 28,
                              color: const Color(0xFF4069D3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: bottomPadding),
                    ],
                  ),
                ]),
          )),
    );
  }
}
