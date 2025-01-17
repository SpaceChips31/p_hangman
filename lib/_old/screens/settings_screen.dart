import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart'; 
import '/l10n/l10n.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onLocaleChange;

  const SettingsScreen({super.key, required this.onLocaleChange});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'en';
  String selectedLayout = 'Standard';
  double wordLength = 9.0;
  bool isLoading = true;

  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage =
          prefs.getString('selectedLanguage') ?? _getDeviceLanguage();
      selectedLayout = prefs.getString('keyboardLayout') ?? 'Standard';
      wordLength = prefs.getDouble('wordLength') ?? 9.0;
      isLoading = false;
      _logger.i('Layout caricato: $selectedLayout');
    });
  }

  String _getDeviceLanguage() {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'it' ? 'it' : 'en';
  }

  Future<void> _saveSettings(
      String language, String layout, double wordLength) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    await prefs.setString('keyboardLayout', layout);
    await prefs.setDouble('wordLength', wordLength);
    _logger.i('Layout salvato: $layout');
  }

  @override
  Widget build(BuildContext context) {
    final settingsTitle = S.of(context).settingsTitle;
    final languageLabel = S.of(context).languageLabel;
    final wordLengthLabel = S.of(context).wordLengthLabel;
    final layoutLabel = S.of(context).layoutLabel;

    return Scaffold(
      appBar: AppBar(
        title: Text(isLoading ? '' : settingsTitle),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text(languageLabel,
                      style: const TextStyle(color: Colors.black)),
                  trailing: DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLanguage = newValue;
                          widget.onLocaleChange(newValue);
                        });
                        _saveSettings(newValue, selectedLayout, wordLength);
                      }
                    },
                    items: <String>['it', 'en']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value == 'it' ? 'Italiano' : 'English',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(layoutLabel,
                      style: const TextStyle(color: Colors.black)),
                  trailing: DropdownButton<String>(
                    value: selectedLayout,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLayout = newValue;
                        });
                        _saveSettings(selectedLanguage, newValue, wordLength);
                      }
                    },
                    items: <String>['Standard', 'QWERTY', 'AZERTY']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(wordLengthLabel,
                      style: const TextStyle(color: Colors.black)),
                  subtitle: Slider(
                    value: wordLength,
                    min: 6,
                    max: 12,
                    divisions: 6,
                    label: wordLength.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        wordLength = value;
                      });
                      _saveSettings(selectedLanguage, selectedLayout, value);
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                ),
              ],
            ),
    );
  }
}
