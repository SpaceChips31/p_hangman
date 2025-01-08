import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        backgroundColor: Colors.grey[800], // OneUI usa spesso colori scuri per l'AppBar
      ),
      body: ListView(
        children: [
          // Sezione per le impostazioni generali
          Card(
            color: Colors.grey[900], // Sfondo scuro per card
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Generali', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Azione quando si clicca
              },
            ),
          ),
          Divider(height: 0, color: Colors.grey[700]),

          // Sezione per le notifiche
          Card(
            color: Colors.grey[900],
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text('Notifiche', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Azione quando si clicca
              },
            ),
          ),
          Divider(height: 0, color: Colors.grey[700]),

          // Altre impostazioni possono seguire questa struttura
        ],
      ),
    );
  }
}