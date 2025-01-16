import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assets/l10n/l10n.dart';
import 'screens/main_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/play_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('selectedLanguage') ?? 'it';
  final themeName = prefs.getString('themeMode') ?? 'system';

  runApp(MyApp(languageCode: languageCode, themeName: themeName));
}

class MyApp extends StatefulWidget {
  final String languageCode;
  final String themeName;

  const MyApp({super.key, required this.languageCode, required this.themeName});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.languageCode);
  }

  void setLocale(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HangMania',
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/settings': (context) => SettingsScreen(onLocaleChange: setLocale),
        '/play': (context) => const PlayScreen(),
      },
    );
  }
}
