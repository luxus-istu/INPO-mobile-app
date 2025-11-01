import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:url_launcher2/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final NewsItem newsItem;

  const NewsCard({
    super.key,
    required this.newsItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _launchURL(),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 52),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsItem.title!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 15,
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
                  fontSize: 15,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F8F8F),
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: newsItem.imageUrl ?? '',
                  width: 362,
                  height: 259,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Container(
                    width: 362,
                    height: 259,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 362,
                    height: 259,
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
