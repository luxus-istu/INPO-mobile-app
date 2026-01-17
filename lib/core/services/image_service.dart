import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageService {
  static void configureImageCache() {
    // Configure image caching settings if needed
  }

  static Widget buildCachedImage({
    required String? imageUrl,
    required double? width,
    required double? height,
    required BoxFit fit,
    required double borderRadius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: width,
        height: height,
        fit: fit,
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
          child: const Icon(Icons.error, color: Colors.grey),
        ),
      ),
    );
  }
}
