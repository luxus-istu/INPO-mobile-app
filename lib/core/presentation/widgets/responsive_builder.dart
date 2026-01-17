import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/utils/responsive_helper.dart';

/// A widget that builds different layouts based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) mobileBuilder;
  final Widget Function(BuildContext)? tabletBuilder;
  final Widget? child;

  const ResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    this.tabletBuilder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isTablet(context) && tabletBuilder != null) {
      return tabletBuilder!(context);
    } else if (child != null) {
      return child!;
    }
    return mobileBuilder(context);
  }

  /// Builder method for simple responsive values
  static T responsiveValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
  }) {
    return ResponsiveHelper.responsiveValue(
      context: context,
      mobile: mobile,
      tablet: tablet,
    );
  }
}

/// A widget that adapts its layout based on orientation
class OrientationBuilder extends StatelessWidget {
  final Widget Function(BuildContext) portraitBuilder;
  final Widget Function(BuildContext) landscapeBuilder;

  const OrientationBuilder({
    super.key,
    required this.portraitBuilder,
    required this.landscapeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandscape ? landscapeBuilder(context) : portraitBuilder(context);
  }
}

/// A widget that combines both responsive and orientation builders
class AdaptiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) mobilePortraitBuilder;
  final Widget Function(BuildContext)? mobileLandscapeBuilder;
  final Widget Function(BuildContext)? tabletPortraitBuilder;
  final Widget Function(BuildContext)? tabletLandscapeBuilder;
  final Widget Function(BuildContext)? desktopBuilder;

  const AdaptiveBuilder({
    super.key,
    required this.mobilePortraitBuilder,
    this.mobileLandscapeBuilder,
    this.tabletPortraitBuilder,
    this.tabletLandscapeBuilder,
    this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = ResponsiveHelper.isTablet(context);

    if (isTablet) {
      if (isLandscape && tabletLandscapeBuilder != null) {
        return tabletLandscapeBuilder!(context);
      } else if (!isLandscape && tabletPortraitBuilder != null) {
        return tabletPortraitBuilder!(context);
      }
    } else {
      // Mobile
      if (isLandscape && mobileLandscapeBuilder != null) {
        return mobileLandscapeBuilder!(context);
      }
    }

    // Fallback to mobile portrait
    return mobilePortraitBuilder(context);
  }
}
