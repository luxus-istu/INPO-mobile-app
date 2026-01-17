import 'package:flutter/material.dart';

/// Extension methods for BuildContext to easily access screen size information
extension ScreenSizeExtensions on BuildContext {
  /// Get the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Check if the current device is a mobile (phone)
  bool get isMobile => screenWidth < 600;

  /// Check if the current device is a tablet
  bool get isTablet => screenWidth >= 600;

  /// Check if the screen is small (typically small phones)
  bool get isSmallScreen => screenWidth < 360;

  /// Check if the screen is medium (typical phones)
  bool get isMediumScreen => screenWidth >= 360 && screenWidth < 600;

  /// Check if the screen is large (tablets and larger)
  bool get isLargeScreen => screenWidth >= 600;

  /// Check if the device is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Get a percentage of the screen width
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);

  /// Get a percentage of the screen height
  double heightPercentage(double percentage) =>
      screenHeight * (percentage / 100);

  /// Get responsive padding based on screen size
  EdgeInsets get responsivePadding => EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      );

  /// Get responsive horizontal padding
  double get responsiveHorizontalPadding => screenWidth * 0.04;

  /// Get responsive vertical padding
  double get responsiveVerticalPadding => screenHeight * 0.02;

  /// Get responsive font size
  double responsiveFontSize(double baseSize) {
    if (screenWidth < 360) {
      return baseSize * 0.9;
    } else if (screenWidth > 450) {
      return baseSize * 1.1;
    }
    return baseSize;
  }

  /// Get responsive icon size
  double responsiveIconSize(double baseSize) {
    if (isMobile) {
      return baseSize;
    } else if (isTablet) {
      return baseSize * 1.2;
    } else {
      return baseSize * 1.5;
    }
  }

  /// Get responsive border radius
  double responsiveBorderRadius(double baseRadius) {
    if (isMobile) {
      return baseRadius;
    } else if (isTablet) {
      return baseRadius * 1.1;
    } else {
      return baseRadius * 1.2;
    }
  }

  /// Get the number of columns for grid layouts based on screen size
  int get gridColumns {
    if (isTablet) {
      return 3;
    } else {
      return 2;
    }
  }

  /// Get responsive aspect ratio for images
  double get imageAspectRatio {
    if (isMobile) {
      return 16 / 9;
    } else {
      return 4 / 3;
    }
  }

  /// Get responsive elevation
  double responsiveElevation(double baseElevation) {
    if (isMobile) {
      return baseElevation;
    } else {
      return baseElevation * 1.2;
    }
  }

  /// Get responsive button size
  Size responsiveButtonSize(Size baseSize) {
    if (isMobile) {
      return baseSize;
    } else {
      return Size(baseSize.width * 1.2, baseSize.height * 1.2);
    }
  }
}
