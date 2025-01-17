import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/controllers/game_controller.dart';
import '../utils/localization/l10n.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameController(),
      child: Consumer<GameController>(
        builder: (context, gameController, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('app_title')),
              backgroundColor: Colors.redAccent,
            ),
            body: gameController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (gameController.isTimerEnabled)
                        _buildTimer(gameController, context),
                      Text(
                        "${AppLocalizations.of(context).translate('app_title')} ${gameController.errorCount} / ${gameController.maxErrors}",
                        style: const TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      const SizedBox(height: 20),
                      _buildWordDisplay(gameController),
                      const SizedBox(height: 30),
                      _buildKeyboard(gameController, context),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildTimer(GameController gameController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        "${AppLocalizations.of(context).translate('time')} ${gameController.remainingTime}s",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: gameController.remainingTime <= 5 ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  Widget _buildWordDisplay(GameController gameController) {
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
            bool isGuessed = gameController.guessedLetters.contains(letter);
            return _buildLetterTile(letter, isGuessed);
          }).toList(),
        ),
        if (row2Count > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gameController.word
                .substring(row1Count)
                .split('')
                .map((letter) {
              bool isGuessed = gameController.guessedLetters.contains(letter);
              return _buildLetterTile(letter, isGuessed);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildLetterTile(String letter, bool isGuessed) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: isGuessed ? Colors.white : Colors.grey[800],
      ),
      child: Center(
        child: Text(
          isGuessed ? letter : "_",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildKeyboard(GameController gameController, BuildContext context) {
    const String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return Column(
      children: [
        for (var i = 0; i < alphabet.length; i += 7)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: alphabet
                .substring(i, (i + 7).clamp(0, alphabet.length))
                .split('')
                .map((letter) {
              bool alreadyGuessed =
                  gameController.guessedLetters.contains(letter);

              return GestureDetector(
                onTap: alreadyGuessed
                    ? null
                    : () {
                        gameController.guessLetter(letter);
                        _checkGameOver(gameController, context);
                      },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: alreadyGuessed ? Colors.grey : Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _checkGameOver(GameController gameController, BuildContext context) {
    if (gameController.isVictory() || gameController.isGameOver()) {
      String title = gameController.isVictory()
          ? AppLocalizations.of(context).translate('win_title')
          : AppLocalizations.of(context).translate('lose_title');
      String message = gameController.isVictory()
          ? "${AppLocalizations.of(context).translate('win_message')} ${gameController.word}."
          : "${AppLocalizations.of(context).translate('lose_message')} ${gameController.word}.";

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) {
          return;
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  gameController.reset();
                },
                child:
                    Text(AppLocalizations.of(context).translate('play_again')),
              ),
              TextButton(
                onPressed: () => context.go('/'),
                child: Text(
                    AppLocalizations.of(context).translate('back_to_home')),
              ),
            ],
          ),
        );
      });
    }
  }
}
