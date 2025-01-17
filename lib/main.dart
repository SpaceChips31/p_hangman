import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../utils/routes/app_router.dart';
import '../utils/theme/app_theme.dart';
import '../utils/localization/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String? savedLanguage = prefs.getString('selectedLanguage');

  String systemLocale = PlatformDispatcher.instance.locale.languageCode;
  final supportedLocales = ['it', 'en'];
  String languageCode = savedLanguage ??
      (supportedLocales.contains(systemLocale) ? systemLocale : 'en');

  if (savedLanguage == null) {
    await prefs.setString('selectedLanguage', languageCode);
  }

  Brightness systemBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  bool isDarkMode =
      prefs.getBool('isDarkMode') ?? (systemBrightness == Brightness.dark);

  runApp(MyApp(languageCode: languageCode, isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final String languageCode;
  final bool isDarkMode;

  const MyApp({
    super.key,
    required this.languageCode,
    required this.isDarkMode,
  });

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _locale;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.languageCode);
    _isDarkMode = widget.isDarkMode;
  }

  void setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(_isDarkMode),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeProvider =
              Provider.of<ThemeProvider?>(context, listen: false);
          if (themeProvider == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp.router(
            title: 'HangMania',
            locale: _locale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('it', ''),
            ],
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.currentTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
