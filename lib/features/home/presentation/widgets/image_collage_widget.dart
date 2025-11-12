import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    _controller.forward();
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    final availableHeight = screenHeight - appBarHeight - statusBarHeight;
    final desiredHeight = availableHeight * 0.8;

    return SizedBox(
      height: desiredHeight,
      child: Stack(
        children: [
          _buildAnimatedImage(
            imageUrl: _getUrl(0),
            width: 110,
            height: 110,
            left: 62,
            top: 42,
            animationDelay: 0,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(1),
            width: 110,
            height: 110,
            right: 62,
            top: 42,
            animationDelay: 0.1,
          ),
          Positioned(
            top: 184,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text(
                'Больше, чем обычный\nтехнический институт',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontFamily: "SF Pro Display",
                  color: const Color(0xFF4069D3),
                ),
              ),
            ),
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(2),
            width: 98,
            height: 98,
            left: 74,
            top: 289,
            animationDelay: 0.2,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(3),
            width: 98,
            height: 98,
            right: 74,
            top: 289,
            animationDelay: 0.3,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(4),
            width: 128,
            height: 128,
            left: 44,
            top: 423,
            animationDelay: 0.4,
          ),
          _buildAnimatedImage(
            imageUrl: _getUrl(5),
            width: 128,
            height: 128,
            right: 44,
            top: 423,
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
