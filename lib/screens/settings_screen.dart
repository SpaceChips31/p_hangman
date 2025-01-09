import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/l10n/l10n.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onLocaleChange;

  const SettingsScreen({super.key, required this.onLocaleChange});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'en';
  double wordLength = 9.0;
  bool isLoading = true;

  late String settingsTitle;
  late String languageLabel;
  late String wordLengthLabel;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';
      wordLength = prefs.getDouble('wordLength') ?? 9.0;

      _updateLabels(); // Aggiorna le variabili con i testi tradotti
      isLoading = false;
    });
  }

  void _updateLabels() {
    settingsTitle = S.of(context).settingsTitle;
    languageLabel = S.of(context).language;
    wordLengthLabel = S.of(context).wordLengthLabel;
  }

  Future<void> _saveSettings(String language, double wordLength) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    await prefs.setDouble('wordLength', wordLength);
  }

  @override
  Widget build(BuildContext context) {
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
                          widget.onLocaleChange(newValue); // Cambia la lingua
                          _updateLabels(); // Aggiorna i testi tradotti
                        });
                        _saveSettings(newValue, wordLength);
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
                      _saveSettings(selectedLanguage, value);
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
