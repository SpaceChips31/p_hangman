import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Titolo in alto al centro
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                'HangMania',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            const Spacer(),
            // Bottone Start al centro
            ElevatedButton(
              onPressed: () {
                // Qui puoi aggiungere la logica per iniziare il gioco
                //print('Start Button Pressed');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            // Icona dell'ingranaggio
            Positioned(
              top: 200.0, // Posiziona l'icona sopra il bottone Start
              right: 50.0, // Allinea a destra rispetto al centro
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Logica per aprire le impostazioni della partita
                 // print('Settings Button Pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}