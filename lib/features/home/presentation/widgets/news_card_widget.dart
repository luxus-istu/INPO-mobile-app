import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:url_launcher/url_launcher_string.dart';

final class NewsCardWidget extends StatelessWidget {
  final NewsItem news;
  const NewsCardWidget(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await launchUrlString(news.link!),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
              color: Color(0xff4069D3),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            CachedNetworkImage(
              imageUrl: news.imageUrl!,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade900,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white70),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade800,
                child: const Icon(
                  Icons.broken_image_rounded,
                  size: 60,
                  color: Colors.white54,
                ),
              ),
              // Опционально: можно добавить fade-in
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 300),
            ),

            // Затемнение для читаемости текста
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: .7),
                  ],
                ),
              ),
            ),

            // Контент поверх
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? "Новость без заголовка",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "SF Pro Display",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
