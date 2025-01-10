import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class GameService {
  final String apiUrl = 'https://random-word-api.herokuapp.com/word';
  final Logger _logger = Logger();

  Future<String?> fetchRandomWord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wordLength = prefs.getDouble('wordLength')?.toInt() ?? 9; 
      final selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';

      String url = '$apiUrl?length=$wordLength';

      if (selectedLanguage == 'it') {
        url += '&lang=it';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          return data.first;
        }
        return null;
      } else {
        throw Exception('Failed to load word: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error fetching word', e);
      return null;
    }
  }
}
