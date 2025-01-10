import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../game/game_service.dart';
import '../game/game_controller.dart';
import '/l10n/l10n.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  late GameController gameController;
  bool isLoading = true;
  String selectedLayout = 'Standard';

  final Logger _logger = Logger();

  final Map<String, String> layouts = {
    'QWERTY': 'QWERTYUIOPASDFGHJKLZXCVBNM',
    'AZERTY': 'AZERTYUIOPQSDFGHJKLMWXCVBN',
    'Standard': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _fetchRandomWord();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLayout = prefs.getString('keyboardLayout') ?? 'Standard';
      _logger.i('Layout caricato: $selectedLayout');
    });
  }

  Future<void> _fetchRandomWord() async {
    final gameService = GameService();
    final word = await gameService.fetchRandomWord();

    if (mounted) {
      setState(() {
        if (word != null) {
          gameController = GameController(word.toUpperCase());
          isLoading = false;
        }
      });
    }
  }

  void _handleLetterPress(String letter) {
    if (!gameController.isGameOver() && !gameController.isVictory()) {
      setState(() {
        gameController.guessLetter(letter);
      });

      if (gameController.isVictory()) {
        _showGameOverDialog(victory: true);
      } else if (gameController.isGameOver()) {
        _showGameOverDialog(victory: false);
      }
    }
  }

  Future<void> _showGameOverDialog({required bool victory}) async {
    final message =
        victory ? S.of(context).victoryMessage : S.of(context).gameOverMessage;
    final action = S.of(context).playAgain;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            victory ? S.of(context).victoryTitle : S.of(context).gameOverTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _fetchRandomWord();
            },
            child: Text(action),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${S.of(context).errorsLabel} ${gameController.errorCount}',
              style: const TextStyle(color: Colors.red, fontSize: 24),
            ),
            const SizedBox(height: 20),
            _buildWordDisplay(),
            const SizedBox(height: 20),
            _buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget _buildWordDisplay() {
    int wordLength = gameController.word.length;
    int row1Count = (wordLength > 6) ? (wordLength / 2).ceil() : wordLength;
    int row2Count = (wordLength > 6) ? wordLength - row1Count : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: gameController.word
              .substring(0, row1Count)
              .split('')
              .map((letter) {
            final isGuessed = gameController.guessedLetters.contains(letter);
            return Container(
              margin: const EdgeInsets.all(4.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  isGuessed ? letter : '_',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          }).toList(),
        ),
        if (row2Count > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gameController.word
                .substring(row1Count)
                .split('')
                .map((letter) {
              final isGuessed = gameController.guessedLetters.contains(letter);
              return Container(
                margin: const EdgeInsets.all(4.0),
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    isGuessed ? letter : '_',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildKeyboard() {
    String alphabet = layouts[selectedLayout]!;

    return Column(
      children: [
        _buildKeyboardRow(alphabet.substring(0, 7)),
        const SizedBox(height: 8),
        _buildKeyboardRow(alphabet.substring(7, 14)),
        const SizedBox(height: 8),
        _buildKeyboardRow(alphabet.substring(14, 21)),
        const SizedBox(height: 8),
        _buildKeyboardRow(alphabet.substring(21, 26)),
      ],
    );
  }

  Widget _buildKeyboardRow(String rowLetters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowLetters.split('').map((letter) {
        final alreadyGuessed = gameController.guessedLetters.contains(letter);
        final isCorrect = gameController.isLetterCorrect(letter);
        final isIncorrect = !isCorrect && alreadyGuessed;

        Color backgroundColor = Colors.white;
        if (isCorrect) {
          backgroundColor = Colors.green;
        } else if (isIncorrect) {
          backgroundColor = Colors.red[200]!;   
        }

        return GestureDetector(
          onTap: alreadyGuessed ? null : () => _handleLetterPress(letter),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
