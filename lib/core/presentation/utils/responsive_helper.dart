import 'package:flutter/material.dart';

/// Responsive helper class for adaptive layout based on device type and screen size
class ResponsiveHelper {
  /// Breakpoint values for different screen sizes
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 840;
  static const double desktopBreakpoint = 1200;

  /// Device type detection
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint &&
        MediaQuery.of(context).size.width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
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
    return MediaQuery.of(context).size.width >= 600;
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
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsetsGeometry responsivePadding({
    required BuildContext context,
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile ?? EdgeInsets.zero;
  }

  /// Get responsive font size
  static double responsiveFontSize({
    required BuildContext context,
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
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
    double? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
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
    } else if (isTablet(context)) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive aspect ratio
  static double responsiveAspectRatio({
    required BuildContext context,
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
    Size? desktopSize,
  }) {
    if (isDesktop(context) && desktopSize != null) {
      return desktopSize;
    } else if (isTablet(context) && tabletSize != null) {
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
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }
}
