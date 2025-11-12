import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/util/responsive.dart';
import 'package:url_launcher2/url_launcher_string.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              const HeaderWidget(labelName: "КОНТАКТЫ"),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: Responsive.getResponsiveValue(
                      context,
                      mobile: 139,
                      tablet: 80,
                      desktop: 100,
                    )),
                    Text(
                      "ПРИСОЕДИНЯЙСЯ\nК НАМ!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Onder",
                        fontSize: Responsive.getResponsiveValue(
                          context,
                          mobile: 14,
                          tablet: 18,
                          desktop: 22,
                        ),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000080),
                      ),
                    ),
                    SizedBox(height: Responsive.getResponsiveValue(
                      context,
                      mobile: 36,
                      tablet: 48,
                      desktop: 56,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: Responsive.getResponsiveValue(
                        context,
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: Responsive.getResponsiveValue(
                            context,
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                          color: const Color(0xFF000080),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrlString("tel:+7(3412)77-49-07");
                          },
                          child: Text(
                            "+7(3412) 77-49-07",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: Responsive.getResponsiveValue(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF000080),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.getResponsiveValue(
                      context,
                      mobile: 26,
                      tablet: 32,
                      desktop: 40,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: Responsive.getResponsiveValue(
                        context,
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                      children: [
                        Icon(
                          Icons.alternate_email_outlined,
                          size: Responsive.getResponsiveValue(
                            context,
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                          color: const Color(0xFF000080),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrlString("mailto:inpo@istu.ru");
                          },
                          child: Text(
                            "inpo@istu.ru",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: Responsive.getResponsiveValue(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF000080),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.getResponsiveValue(
                      context,
                      mobile: 57,
                      tablet: 72,
                      desktop: 84,
                    )),
                    Image.asset(
                      "assets/images/contacts_image.jpg",
                      scale: Responsive.getResponsiveValue(
                        context,
                        mobile: 4,
                        tablet: 3,
                        desktop: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const AnimatedFabMenu(),
    );
  }
}
