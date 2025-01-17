import 'package:flutter/material.dart';
import '../assets/l10n/l10n.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTitle = S.of(context).appTitle;
    final startButton = S.of(context).startButton;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 75.0),
                Text(
                  appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 650.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/play');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: Text(
                    startButton,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.settings, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
