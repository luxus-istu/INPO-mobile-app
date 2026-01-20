import 'package:flutter/material.dart';

/// Responsive helper class for adaptive layout based on device type and screen size
class ResponsiveHelper {
  /// Breakpoint values for different screen sizes
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 840;
  static const double desktopBreakpoint = 1200;

  /// Device type detection
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  /// Device type detection
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint;
  }

  /// Screen size categories
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 360 &&
        MediaQuery.of(context).size.width < 600;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < desktopBreakpoint;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  /// Get responsive value based on screen size
  static T responsiveValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    }
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsetsGeometry responsivePadding({
    required BuildContext context,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
  }) {
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile ?? EdgeInsets.zero;
  }

  /// Get responsive font size
  static double responsiveFontSize({
    required BuildContext context,
    required double mobile,
    double? tablet,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isTablet(context) && tablet != null) {
      return tablet;
    }

    // Scale font size based on screen width for mobile devices
    if (screenWidth < 360) {
      return mobile * 0.9;
    } else if (screenWidth > 450) {
      return mobile * 1.1;
    }

    return mobile;
  }

  /// Get responsive spacing
  static double responsiveSpacing({
    required BuildContext context,
    required double mobile,
    double? tablet,
  }) {
    if (isTablet(context) && tablet != null) {
      return tablet;
    }

    // Scale spacing based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return mobile * 0.8;
    } else if (screenWidth > 450) {
      return mobile * 1.2;
    }

    return mobile;
  }

  /// Get number of columns for grid layouts
  static int responsiveGridColumns({
    required BuildContext context,
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    if (isDesktop(context)) {
      return desktop;
    }
    if (isTablet(context)) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive aspect ratio
  static double responsiveAspectRatio({
    required BuildContext context,
    required double mobile,
    double? tablet,
  }) {
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get screen width percentage
  static double screenWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  /// Get screen height percentage
  static double screenHeightPercentage(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get responsive image size
  static Size responsiveImageSize({
    required BuildContext context,
    required Size mobileSize,
    Size? tabletSize,
  }) {
    if (isTablet(context) && tabletSize != null) {
      return tabletSize;
    }
    return mobileSize;
  }

  /// Get responsive border radius
  static double responsiveBorderRadius({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    }
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Responsive typography scale based on screen size
  static double responsiveFontSizeScale({
    required BuildContext context,
    required double baseSize,
    double scaleFactor = 1.0,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isDesktop(context)) {
      return baseSize * scaleFactor * 1.2;
    } else if (isTablet(context)) {
      return baseSize * scaleFactor * 1.1;
    } else if (screenWidth > 450) {
      return baseSize * scaleFactor * 1.05;
    } else if (screenWidth < 360) {
      return baseSize * scaleFactor * 0.95;
    }

    return baseSize * scaleFactor;
  }

  /// Get responsive typography preset
  static TextStyle responsiveTypography({
    required BuildContext context,
    required TextStyle baseStyle,
    TextStyle? tabletStyle,
    TextStyle? desktopStyle,
  }) {
    if (isDesktop(context) && desktopStyle != null) {
      return desktopStyle;
    }
    if (isTablet(context) && tabletStyle != null) {
      return tabletStyle;
    }
    return baseStyle;
  }

  /// Get device type as string for debugging
  static String getDeviceType(BuildContext context) {
    if (isDesktop(context)) {
      return 'Desktop';
    } else if (isTablet(context)) {
      return 'Tablet';
    } else if (isLargeScreen(context)) {
      return 'Large Mobile';
    } else if (isMediumScreen(context)) {
      return 'Medium Mobile';
    } else {
      return 'Small Mobile';
    }
  }

  /// Check if screen size is between min and max width
  static bool isScreenWidthBetween({
    required BuildContext context,
    required double minWidth,
    required double maxWidth,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= minWidth && screenWidth <= maxWidth;
  }
}
