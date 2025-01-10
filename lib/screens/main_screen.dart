import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Intl.message(
                    'HangMania', 
                    name: 'appTitle', 
                    desc: 'The title of the app',
                    locale: Localizations.localeOf(context).toString(), 
                  ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: Text(
                    Intl.message(
                      'Start',
                      name: 'startButton',
                      desc: 'The label on the start button',
                      locale: Localizations.localeOf(context).toString(),
                    ),
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
