import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/services/image_service.dart';

final class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ImageService.buildCachedImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
    );
  }
}
