import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class ImageCollageWidget extends StatefulWidget {
  final List<String> imageUrls;
  final bool isTablet;

  const ImageCollageWidget({
    super.key,
    required this.imageUrls,
    this.isTablet = false,
  });

  @override
  State<ImageCollageWidget> createState() => _ImageCollageWidgetState();
}

final class _ImageCollageWidgetState extends State<ImageCollageWidget>
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

    // Adjust base layout based on device type
    double baseWidth;
    double heightPercentage;

    if (widget.isTablet) {
      baseWidth = 800.0;
      heightPercentage = 0.5;
    } else {
      baseWidth = 375.0;
      heightPercentage = 0.6;
    }

    // Коэффициент масштабирования на основе ширины экрана
    final scaleFactor = (screenWidth / baseWidth).clamp(0.8, 1.5);

    // Адаптивная высота виджета
    final desiredHeight = screenHeight * heightPercentage;

    // Адаптивные размеры изображений (different layout for tablets)
    final imageSize1 =
        widget.isTablet ? 130.0 * scaleFactor : 110.0 * scaleFactor;
    final imageSize2 =
        widget.isTablet ? 110.0 * scaleFactor : 98.0 * scaleFactor;
    final imageSize3 =
        widget.isTablet ? 140.0 * scaleFactor : 128.0 * scaleFactor;

    // Адаптивные отступы
    final horizontalPadding =
        widget.isTablet ? 24.0 * scaleFactor : 16.0 * scaleFactor;

    // Different layout for tablets vs mobile
    if (widget.isTablet) {
      // Tablet layout - more spread out
      final leftOffset1 = 80.0 * scaleFactor;
      final leftOffset2 = 100.0 * scaleFactor;
      final leftOffset3 = 60.0 * scaleFactor;
      final topOffset1 = 50.0 * scaleFactor;
      final topOffset2 = 280.0 * scaleFactor;
      final topOffset3 = 400.0 * scaleFactor;
      final textTop = 180.0 * scaleFactor;
      final fontSize = 36.0 * scaleFactor;

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
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  AppLocalizations.of(context)!.moreThanOrdinaryInstitute,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
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
    } else {
      // Mobile layout
      final leftOffset1 = 62.0 * scaleFactor;
      final leftOffset2 = 74.0 * scaleFactor;
      final leftOffset3 = 44.0 * scaleFactor;
      final topOffset1 = 42.0 * scaleFactor;
      final topOffset2 = 289.0 * scaleFactor;
      final topOffset3 = 423.0 * scaleFactor;
      final textTop = 184.0 * scaleFactor;
      final fontSize = 32.0 * scaleFactor;

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
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  AppLocalizations.of(context)!.moreThanOrdinaryInstitute,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
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
