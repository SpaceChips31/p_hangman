import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HangMania',
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/play': (context) => const PlayScreen()
      },
    );
  }
}
