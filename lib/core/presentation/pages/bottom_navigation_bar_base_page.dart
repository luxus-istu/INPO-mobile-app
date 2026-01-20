import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

class BottomNavigationBarBasePage extends StatelessWidget {
  final StatefulNavigationShell shell;
  const BottomNavigationBarBasePage(this.shell, {super.key});

  void _onTap(int index) {
    shell.goBranch(
      index,
      initialLocation: index == shell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: this.shell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xff454545),
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: this.shell.currentIndex,
        selectedItemColor: Color(0xff4069D3),
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.menuHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.engineering_outlined),
              label: AppLocalizations.of(context)!.menuSpecialties),
          BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined),
              label: AppLocalizations.of(context)!.menuChat),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_outlined),
              label: AppLocalizations.of(context)!.menuNews),
        ],
      ),
    );
  }
}
