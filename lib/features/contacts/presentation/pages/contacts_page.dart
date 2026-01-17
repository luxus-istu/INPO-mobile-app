import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final isTablet = context.isTablet;
    final isMobile = context.isMobile;

    // Responsive sizing
    final titleFontSize = isTablet ? 16.0 : 14.0;
    final contactFontSize = isTablet ? 22.0 : 20.0;
    final iconSize = isTablet ? 24.0 : 20.0;
    final imageHeight = isTablet ? 250.0 : 200.0;
    final borderRadius = isTablet ? 18.0 : 15.0;
    final horizontalPadding = isTablet ? 24.0 : 16.0;
    final spacing = isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(labelName: "КОНТАКТЫ"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: isMobile
                  ? _buildMobileLayout(
                      titleFontSize,
                      contactFontSize,
                      iconSize,
                      imageHeight,
                      borderRadius,
                      spacing,
                    )
                  : _buildTabletDesktopLayout(
                      titleFontSize,
                      contactFontSize,
                      iconSize,
                      imageHeight,
                      borderRadius,
                      spacing,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: const AnimatedFabMenu(),
    );
  }

  Widget _buildMobileLayout(
    double titleFontSize,
    double contactFontSize,
    double iconSize,
    double imageHeight,
    double borderRadius,
    double spacing,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: spacing * 5),
        Text(
          "ПРИСОЕДИНЯЙСЯ\nК НАМ!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Onder",
            fontSize: titleFontSize,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000080),
          ),
        ),
        SizedBox(height: spacing * 1.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_outlined,
              size: iconSize,
              color: Color(0xFF000080),
            ),
            SizedBox(width: spacing),
            GestureDetector(
              onTap: () async {
                await launchUrlString("tel:+7(3412)77-49-07");
              },
              child: Text(
                "+7(3412) 77-49-07",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: contactFontSize,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing * 1.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alternate_email_outlined,
              size: iconSize,
              color: Color(0xFF000080),
            ),
            SizedBox(width: spacing),
            GestureDetector(
              onTap: () async {
                await launchUrlString("mailto:inpo@istu.ru");
              },
              child: Text(
                "inpo@istu.ru",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: contactFontSize,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing * 2.85),
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            "assets/images/contacts_image.webp",
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: imageHeight,
                color: Colors.grey[300],
                child: Icon(
                  Icons.broken_image,
                  size: iconSize * 2,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabletDesktopLayout(
    double titleFontSize,
    double contactFontSize,
    double iconSize,
    double imageHeight,
    double borderRadius,
    double spacing,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left column - Contact information
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ПРИСОЕДИНЯЙСЯ\nК НАМ!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Onder",
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000080),
                ),
              ),
              SizedBox(height: spacing * 1.8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: iconSize,
                    color: Color(0xFF000080),
                  ),
                  SizedBox(width: spacing),
                  GestureDetector(
                    onTap: () async {
                      await launchUrlString("tel:+7(3412)77-49-07");
                    },
                    child: Text(
                      "+7(3412) 77-49-07",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: contactFontSize,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000080),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 1.3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alternate_email_outlined,
                    size: iconSize,
                    color: Color(0xFF000080),
                  ),
                  SizedBox(width: spacing),
                  GestureDetector(
                    onTap: () async {
                      await launchUrlString("mailto:inpo@istu.ru");
                    },
                    child: Text(
                      "inpo@istu.ru",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: contactFontSize,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000080),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: spacing * 2),
        // Right column - Image
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.asset(
              "assets/images/contacts_image.webp",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image,
                    size: iconSize * 2,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
