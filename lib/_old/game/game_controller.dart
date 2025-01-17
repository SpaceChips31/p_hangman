class GameController {
  final String word;
  final Set<String> guessedLetters = {};
  final Set<String> correctLetters = {};
  int errorCount = 0;
  final int maxErrors = 6;

  GameController(this.word);

  bool guessLetter(String letter) {
    if (guessedLetters.contains(letter)) {
      return false;
    }

    guessedLetters.add(letter);
    if (word.contains(letter)) {
      correctLetters.add(letter);
    } else {
      errorCount++;
    }
    return true;
  }

  bool isVictory() {
    return word.split('').every((letter) => guessedLetters.contains(letter));
  }

  bool isGameOver() {
    return errorCount >= maxErrors;
  }

  String getDisplayWord() {
    return word
        .split('')
        .map((letter) => guessedLetters.contains(letter) ? letter : '_')
        .join(' ');
  }

  bool isLetterCorrect(String letter) {
    return correctLetters.contains(letter);
  }
}
