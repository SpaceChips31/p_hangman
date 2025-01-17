import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GameService {
  final String apiUrl = 'https://random-word-api.herokuapp.com/word';

  final Map<String, List<String>> fallbackWords = {
    'en': [
      'flutter',
      'hangman',
      'developer',
      'keyboard',
      'dart',
      'programming'
    ],
    'it': [
      'flutter',
      'impiccato',
      'sviluppatore',
      'tastiera',
      'dart',
      'programmazione'
    ],
  };

  Future<String> fetchRandomWord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';
      final wordLength = prefs.getDouble('wordLength')?.toInt() ?? 9;

      String url = '$apiUrl?lang=$selectedLanguage&length=$wordLength';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          return data.first.toUpperCase();
        }
      }

      return _getFallbackWord(selectedLanguage, wordLength);
    } catch (e) {
      return _getFallbackWord('en', 9);
    }
  }

  String _getFallbackWord(String language, int length) {
    List<String> words = fallbackWords[language] ?? fallbackWords['en']!;
    List<String> filteredWords =
        words.where((word) => word.length == length).toList();

    if (filteredWords.isEmpty) {
      return words[Random().nextInt(words.length)].toUpperCase();
    }

    return filteredWords[Random().nextInt(filteredWords.length)].toUpperCase();
  }
}
