import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme/app_theme.dart';
import '../utils/localization/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'en';
  bool isDarkMode = false;
  double wordLength = 9.0;
  bool isTimerEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String systemLocale = Platform.localeName.split('_')[0];
      final supportedLocales = ['it', 'en'];

      bool isThemeSet = prefs.getBool('themeSet') ?? false;
      Brightness systemBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      bool defaultDarkMode = isThemeSet
          ? (prefs.getBool('isDarkMode') ?? false)
          : (systemBrightness == Brightness.dark);

      setState(() {
        selectedLanguage = prefs.getString('selectedLanguage') ??
            (supportedLocales.contains(systemLocale) ? systemLocale : 'en');
        isDarkMode = defaultDarkMode;
        wordLength = prefs.getDouble('wordLength') ?? 9.0;
        isTimerEnabled = prefs.getBool('isTimerEnabled') ?? false;
      });

      if (!isThemeSet) {
        await prefs.setBool('themeSet', true);
        await prefs.setBool('isDarkMode', defaultDarkMode);
      }
    } catch (e) {
      debugPrint("⚠️ Errore nel caricamento delle impostazioni: $e");
    }
  }

  Future<void> _saveSettings(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: selectedLanguage.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildSettingTile(
                  title: AppLocalizations.of(context).translate('language'),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLanguage = newValue;
                        });
                        _saveSettings('selectedLanguage', newValue);
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'it', child: Text("Italiano")),
                      DropdownMenuItem(value: 'en', child: Text("English")),
                    ],
                    dropdownColor: Colors.white,
                  ),
                ),
                _buildSettingTile(
                  title: AppLocalizations.of(context).translate('dark_mode'),
                  child: Switch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        isDarkMode = value;
                      });
                      _saveSettings('isDarkMode', value);
                      themeProvider.setTheme(value ? 'dark' : 'light');
                    },
                  ),
                ),
                _buildSettingTile(
                  title: AppLocalizations.of(context).translate('word_length'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Slider(
                        value: wordLength,
                        min: 6,
                        max: 12,
                        divisions: 6,
                        label: wordLength.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            wordLength = value;
                          });
                          _saveSettings('wordLength', value);
                        },
                      ),
                    ],
                  ),
                ),
                _buildSettingTile(
                  title: AppLocalizations.of(context).translate('enable_timer'),
                  child: Switch(
                    value: isTimerEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isTimerEnabled = value;
                      });
                      _saveSettings('isTimerEnabled', value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: Text(
                      AppLocalizations.of(context).translate('back_to_home')),
                ),
              ],
            ),
    );
  }

  Widget _buildSettingTile({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(title),
        trailing: SizedBox(
          width: 150,
          child: Align(
            alignment: Alignment.centerRight,
            child: child,
          ),
        ),
      ),
    );
  }
}
