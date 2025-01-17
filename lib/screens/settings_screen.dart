import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../assets/l10n/l10n.dart';

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
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
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
                _buildSectionHeader(languageLabel),
                _buildSettingTile(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(languageLabel,
                          style: const TextStyle(color: Colors.black)),
                      DropdownButton<String>(
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
                    ],
                  ),
                ),
                _buildSectionHeader(layoutLabel),
                _buildSettingTile(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(layoutLabel,
                          style: const TextStyle(color: Colors.black)),
                      DropdownButton<String>(
                        value: selectedLayout,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLayout = newValue;
                            });
                            _saveSettings(
                                selectedLanguage, newValue, wordLength);
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
                    ],
                  ),
                ),
                _buildSectionHeader(wordLengthLabel),
                _buildSettingTile(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(wordLengthLabel,
                          style: const TextStyle(color: Colors.black)),
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
                          _saveSettings(
                              selectedLanguage, selectedLayout, value);
                        },
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
