import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gioco dell'Impiccato"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Parola Segreta:",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "_ _ _ _ _ _",
            style: TextStyle(fontSize: 32, letterSpacing: 8),
          ),
          const SizedBox(height: 30),
          const Text(
            "Tastiera Placeholder",
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text("Torna alla Home"),
          ),
        ],
      ),
    );
  }
}
