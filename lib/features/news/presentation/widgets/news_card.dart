import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;
  final bool isTablet;
  final bool isDesktop;

  const NewsCard({
    super.key,
    required this.newsItem,
    this.isTablet = false,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final titleFontSize = isDesktop
        ? 18.0
        : isTablet
            ? 16.0
            : 15.0;
    final dateFontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 15.0;
    final imageWidth = isDesktop
        ? 450.0
        : isTablet
            ? 400.0
            : 362.0;
    final imageHeight = isDesktop
        ? 320.0
        : isTablet
            ? 280.0
            : 259.0;
    final borderRadius = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final padding = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final bottomPadding = isDesktop
        ? 60.0
        : isTablet
            ? 56.0
            : 52.0;

    return Container(
      child: GestureDetector(
        onTap: () => _launchURL(),
        child: Padding(
          padding: EdgeInsets.only(
            right: padding,
            left: padding,
            bottom: bottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsItem.title!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Onder",
                  color: Color(0xFF000080),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                newsItem.date!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: dateFontSize,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F8F8F),
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImage(
                  imageUrl: newsItem.imageUrl ?? '',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    final uri = Uri.parse(newsItem.link!);
    if (!await launchUrl(uri)) {}
  }
}
