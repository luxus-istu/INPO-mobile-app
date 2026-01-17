import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Text(
        AppLocalizations.of(context)!.thinking,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
