import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';

class ImageCollageWidget extends StatefulWidget {
  final List<String> imageUrls;

  const ImageCollageWidget({
    super.key,
    required this.imageUrls,
  });

  @override
  State<ImageCollageWidget> createState() => _ImageCollageWidgetState();
}

class _ImageCollageWidgetState extends State<ImageCollageWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    // Запускаем анимацию один раз при инициализации, а не при каждом build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _getUrl(int index) {
    if (widget.imageUrls.length > index && widget.imageUrls[index].isNotEmpty) {
      return widget.imageUrls[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    const appBarHeight = kToolbarHeight;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    final availableHeight = screenHeight - appBarHeight - statusBarHeight;
    final desiredHeight = availableHeight * 0.8;

    double responsiveSize(double base) {
      final scaleFactor = (screenWidth / 375)
          .clamp(0.85, Responsive.isDesktop(context) ? 1.6 : 1.2);
      return base * scaleFactor;
    }

    final imageSize1 = responsiveSize(110.0);
    final imageSize2 = responsiveSize(98.0);
    final imageSize3 = responsiveSize(128.0);
    final leftOffset1 = Responsive.getResponsiveValue(
      context,
      mobile: 62.0,
      tablet: 80.0,
      desktop: 100.0,
    );
    final leftOffset2 = Responsive.getResponsiveValue(
      context,
      mobile: 74.0,
      tablet: 90.0,
      desktop: 110.0,
    );
    final leftOffset3 = Responsive.getResponsiveValue(
      context,
      mobile: 44.0,
      tablet: 60.0,
      desktop: 80.0,
    );
    final topOffset1 = Responsive.getResponsiveValue(
      context,
      mobile: 42.0,
      tablet: 60.0,
      desktop: 80.0,
    );
    final topOffset2 = Responsive.getResponsiveValue(
      context,
      mobile: 289.0,
      tablet: 350.0,
      desktop: 400.0,
    );
    final topOffset3 = Responsive.getResponsiveValue(
      context,
      mobile: 423.0,
      tablet: 500.0,
      desktop: 580.0,
    );
    final textTop = Responsive.getResponsiveValue(
      context,
      mobile: 184.0,
      tablet: 220.0,
      desktop: 260.0,
    );

    return SizedBox(
      height: desiredHeight,
      child: Stack(
        children: [
          _buildAnimatedImage(
            imageUrl: _getUrl(0),
            width: imageSize1,
            height: imageSize1,
            left: leftOffset1,
            top: topOffset1,
            animationDelay: 0,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(1),
            width: imageSize1,
            height: imageSize1,
            right: leftOffset1,
            top: topOffset1,
            animationDelay: 0.1,
          ),
          Positioned(
            top: textTop,
            child: Padding(
              padding: Responsive.getResponsivePadding(
                context,
                mobile: const EdgeInsets.symmetric(horizontal: 24),
                tablet: const EdgeInsets.symmetric(horizontal: 40),
                desktop: const EdgeInsets.symmetric(horizontal: 60),
              ),
              child: Text(
                'Больше, чем обычный\nтехнический институт',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.getResponsiveValue(
                    context,
                    mobile: 32,
                    tablet: 40,
                    desktop: 48,
                  ),
                  fontWeight: FontWeight.w700,
                  fontFamily: "SF Pro Display",
                  color: const Color(0xFF4069D3),
                ),
              ),
            ),
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(2),
            width: imageSize2,
            height: imageSize2,
            left: leftOffset2,
            top: topOffset2,
            animationDelay: 0.2,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(3),
            width: imageSize2,
            height: imageSize2,
            right: leftOffset2,
            top: topOffset2,
            animationDelay: 0.3,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(4),
            width: imageSize3,
            height: imageSize3,
            left: leftOffset3,
            top: topOffset3,
            animationDelay: 0.4,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(5),
            width: imageSize3,
            height: imageSize3,
            right: leftOffset3,
            top: topOffset3,
            animationDelay: 0.5,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedImage({
    required String? imageUrl,
    required double width,
    required double height,
    double? left,
    double? top,
    double? right,
    double? bottom,
    required double animationDelay,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2.0;
    final centerY = screenSize.height / 2.0;

    double finalDx = 0;
    double finalDy = 0;
    if (left != null) finalDx = left;
    if (right != null) finalDx = screenSize.width - right - width;
    if (top != null) finalDy = top;
    if (bottom != null) finalDy = screenSize.height - bottom - height;

    final startDx = centerX - width / 2;
    final startDy = centerY - height / 2;

    final _ = CurvedAnimation(
      parent: _controller,
      curve: Interval(animationDelay, 1.0, curve: Curves.elasticOut),
    );

    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
          begin: Offset(startDx, startDy), end: Offset(finalDx, finalDy)),
      duration: _controller.duration!,
      curve: Curves.elasticOut,
      builder: (context, Offset offset, child) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: child!,
        );
      },
      child: _buildImageWidget(imageUrl, width, height),
    );
  }

  Widget _buildImageWidget(String? imageUrl, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }
}
