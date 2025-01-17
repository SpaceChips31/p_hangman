import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'HangMania',
      'play': 'Play',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'word_length': 'Word Length',
      'enable_timer': 'Enable Timer',
      'back_to_home': 'Back to Home',
      'win_title': 'You win!',
      'lose_title': 'Game over!',
      'win_message': 'Congratulations! The word was',
      'lose_message': 'Too bad! The word was',
      'play_again': 'Play Again',
      'error_count': 'Errors: ',
      'Timer': 'Time remaining:',
    },
    'it': {
      'app_title': 'HangMania',
      'play': 'Gioca',
      'settings': 'Impostazioni',
      'language': 'Lingua',
      'theme': 'Tema',
      'dark_mode': 'Tema Scuro',
      'word_length': 'Lunghezza della parola',
      'enable_timer': 'Attiva Timer',
      'back_to_home': 'Torna alla Home',
      'win_title': 'Hai vinto!',
      'lose_title': 'Hai perso!',
      'win_message': 'Complimenti! La parola era',
      'lose_message': 'Peccato! La parola era',
      'play_again': 'Rigioca',
      'error_count': 'Errori: ',
      'Timer': 'Tempo restante:',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
