import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/presentation/widgets/animated_fab_menu.dart';
import 'package:inpo_mobile_app/presentation/widgets/header_widget.dart';
import 'package:url_launcher2/url_launcher_string.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HeaderWidget(labelName: "КОНТАКТЫ"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 139),
              const Text("ПРИСОЕДИНЯЙСЯ\nК НАМ!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Onder",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000080),
                  )),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  const Icon(Icons.phone_outlined,
                      size: 20, color: Color(0xFF000080)),
                  GestureDetector(
                    onTap: () async {
                      await launchUrlString("tel:+7(3412)77-49-07");
                    },
                    child: const Text("+7(3412) 77-49-07",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000080),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  const Icon(Icons.alternate_email_outlined,
                      size: 20, color: Color(0xFF000080)),
                  GestureDetector(
                      onTap: () async {
                        await launchUrlString("mailto:inpo@istu.ru");
                      },
                      child: const Text("inpo@istu.ru",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000080),
                          ))),
                ],
              ),
              const SizedBox(height: 57),
              Image.asset("assets/images/contacts_image.jpg", scale: 4),
            ],
          ),
        ],
      ),
      floatingActionButton: const AnimatedFabMenu(),
    );
  }
}
