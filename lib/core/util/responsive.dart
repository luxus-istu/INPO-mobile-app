import 'package:flutter/material.dart';

class Responsive {
  static const double tabletBreakpoint = 600.0;
  static const double desktopBreakpoint = 1200.0;

  // Кешируем MediaQuery для оптимизации
  static MediaQueryData _getMediaQuery(BuildContext context) {
    return MediaQuery.of(context);
  }

  static bool isMobile(BuildContext context) {
    return _getMediaQuery(context).size.width < tabletBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = _getMediaQuery(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return _getMediaQuery(context).size.width >= desktopBreakpoint;
  }

  static double getWidth(BuildContext context) {
    return _getMediaQuery(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return _getMediaQuery(context).size.height;
  }

  static double getResponsiveValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) {
      return 5;
    } else if (isTablet(context)) {
      return 4;
    }
    return 3;
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 1200;
    } else if (isTablet(context)) {
      return 800;
    }
    return double.infinity;
  }
}

