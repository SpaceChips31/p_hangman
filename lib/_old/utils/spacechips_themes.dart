import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> loadThemes() async {
  final String jsonResponse =
      await rootBundle.loadString('assets/themes/themes.json');
  final Map<String, dynamic> themeData = json.decode(jsonResponse);
  return themeData['themes'];
}

ThemeData createThemeFromJson(Map<String, dynamic> themeData) {
  final primaryColor = Color(int.parse(themeData['primaryColor'], radix: 16));
  final accentColor = Color(int.parse(themeData['accentColor'], radix: 16));
  final backgroundColor =
      Color(int.parse(themeData['backgroundColor'], radix: 16));
  final buttonColor = Color(int.parse(themeData['buttonColor'], radix: 16));
  final textColor = Color(int.parse(themeData['textColor'], radix: 16));

  return ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
      surface: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    buttonTheme: ButtonThemeData(buttonColor: buttonColor),
    textTheme: TextTheme(bodyLarge: TextStyle(color: textColor)),
  );
}

Future<void> saveThemeMode(String themeMode) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('themeMode', themeMode);
}

Future<String> loadThemeMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('themeMode') ?? 'light';
}

Future<void> changeTheme(
    String themeMode, void Function(Map<String, dynamic>) onThemeChange) async {
  final themes = await loadThemes();
  final selectedTheme = themeMode == 'dark' ? themes['dark'] : themes['light'];

  await saveThemeMode(themeMode);

  onThemeChange(selectedTheme);
}
