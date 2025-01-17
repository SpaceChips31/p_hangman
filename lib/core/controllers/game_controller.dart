import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/game_service.dart';

class GameController extends ChangeNotifier {
  late String word;
  final Set<String> guessedLetters = {};
  int errorCount = 0;
  final int maxErrors;
  bool isLoading = true;
  bool isTimerEnabled = false; // ✅ Controllo se il timer è attivo
  int remainingTime = 30; // ✅ Secondi di default per il timer
  Timer? _timer;
  bool _isDisposed = false;

  final GameService _gameService = GameService();

  GameController({this.maxErrors = 6}) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isTimerEnabled = prefs.getBool('isTimerEnabled') ?? false;
    _fetchNewWord();
  }

  Future<void> _fetchNewWord() async {
    isLoading = true;
    notifyListeners();

    word = await _gameService.fetchRandomWord();
    isLoading = false;
    notifyListeners();

    if (isTimerEnabled) {
      _startTimer();
    }
  }

  void _startTimer() {
    remainingTime = 30; // ✅ Tempo iniziale
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed) return; // ✅ Evita di aggiornare lo stato dopo dispose()
      if (remainingTime > 0) {
        remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
        _handleGameOver();
      }
    });
  }

  bool guessLetter(String letter) {
    if (guessedLetters.contains(letter) || isLoading) {
      return false;
    }

    guessedLetters.add(letter);
    if (!word.contains(letter)) {
      errorCount++;
    }

    if (isGameOver()) {
      _handleGameOver();
    }

    notifyListeners();
    return true;
  }

  void _handleGameOver() {
    _timer?.cancel();
    notifyListeners();
  }

  bool isVictory() {
    return word.split('').every((letter) => guessedLetters.contains(letter));
  }

  bool isGameOver() {
    return errorCount >= maxErrors || remainingTime == 0;
  }

  void reset() {
    guessedLetters.clear();
    errorCount = 0;
    _timer?.cancel();
    _fetchNewWord();
  }

  @override
  void dispose() {
    _isDisposed = true; 
    _timer?.cancel(); 
    super.dispose();
  }
}
