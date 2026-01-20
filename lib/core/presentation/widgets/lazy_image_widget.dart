import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/image_widget.dart';

/// A widget that provides lazy loading for images in scrollable content
/// Only loads images when they come into viewport
final class LazyImageWidget extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const LazyImageWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 16,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<LazyImageWidget> createState() => _LazyImageWidgetState();
}

class _LazyImageWidgetState extends State<LazyImageWidget> {
  bool _isInView = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_checkVisibility);
  }

  @override
  void didUpdateWidget(LazyImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _isInView = false;
      WidgetsBinding.instance.addPostFrameCallback(_checkVisibility);
    }
  }

  void _checkVisibility(_) {
    if (!mounted) return;

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

    // Check if widget is visible in viewport with some buffer
    final bool isVisible = position.dy < screenSize.height + 100 &&
        position.dy + size.height > -100;

    if (isVisible && !_isInView) {
      setState(() {
        _isInView = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      width: widget.width,
      height: widget.height,
      child: _isInView
          ? ImageWidget(
              imageUrl: widget.imageUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              borderRadius: widget.borderRadius,
            )
          : widget.placeholder ??
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[100],
                child: const Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 32,
                ),
              ),
    );
  }
}
