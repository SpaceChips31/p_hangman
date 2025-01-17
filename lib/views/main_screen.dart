import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/localization/l10n.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)
                  .translate('app_title'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.go('/play'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                AppLocalizations.of(context)
                    .translate('play'),
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/settings'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                AppLocalizations.of(context)
                    .translate('settings'),
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
