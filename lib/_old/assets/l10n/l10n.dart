// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HangMania`
  String get appTitle {
    return Intl.message(
      'HangMania',
      name: 'appTitle',
      desc: 'The title of the app',
      args: [],
    );
  }

  /// `Start`
  String get startButton {
    return Intl.message(
      'Start',
      name: 'startButton',
      desc: 'The label on the start button',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'The label for the settings button',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'Title for settings screen',
      args: [],
    );
  }

  /// `Language`
  String get languageLabel {
    return Intl.message(
      'Language',
      name: 'languageLabel',
      desc: 'Label for the language selection setting',
      args: [],
    );
  }

  /// `Word Length`
  String get wordLengthLabel {
    return Intl.message(
      'Word Length',
      name: 'wordLengthLabel',
      desc: 'Label for the word length selection setting',
      args: [],
    );
  }

  /// `Error loading word`
  String get errGetWord {
    return Intl.message(
      'Error loading word',
      name: 'errGetWord',
      desc: 'Error message for failed word loading',
      args: [],
    );
  }

  /// `You win!`
  String get victoryMessage {
    return Intl.message(
      'You win!',
      name: 'victoryMessage',
      desc: 'Victory message',
      args: [],
    );
  }

  /// `Game over!`
  String get gameOverMessage {
    return Intl.message(
      'Game over!',
      name: 'gameOverMessage',
      desc: 'Game over message',
      args: [],
    );
  }

  /// `Play again?`
  String get playAgain {
    return Intl.message(
      'Play again?',
      name: 'playAgain',
      desc: 'Play again button label',
      args: [],
    );
  }

  /// `Word guessed!`
  String get victoryTitle {
    return Intl.message(
      'Word guessed!',
      name: 'victoryTitle',
      desc: 'Victory message title',
      args: [],
    );
  }

  /// `The man was Hanged!`
  String get gameOverTitle {
    return Intl.message(
      'The man was Hanged!',
      name: 'gameOverTitle',
      desc: 'Game over message title',
      args: [],
    );
  }

  /// `Errors:`
  String get errorsLabel {
    return Intl.message(
      'Errors:',
      name: 'errorsLabel',
      desc: 'Errors label',
      args: [],
    );
  }

  /// `Keyboard layout:`
  String get layoutLabel {
    return Intl.message(
      'Keyboard layout:',
      name: 'layoutLabel',
      desc: 'Keyboard layout label',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
