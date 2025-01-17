import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/routes/app_router.dart';
import 'utils/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('selectedLanguage') ?? 'it';
  final themeName = prefs.getString('themeMode') ?? 'light';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(widget.themeName)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Hangman Game',
            locale: _locale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('it', ''),
            ],
            localizationsDelegates: const [
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
