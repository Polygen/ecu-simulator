import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.pt;

    return Scaffold(
      backgroundColor: semantics.background,
      appBar: AppBar(
        backgroundColor: semantics.surface,
        title: Text('Ayarlar & Hakkında', style: semantics.textStyleCardTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: semantics.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: semantics.borderDefault),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info, color: semantics.primary),
                  title: Text('Hakkında', style: semantics.textStyleCardTitle),
                  subtitle: Text(
                    'Preditech ECU Simulator v1.0.0\nOBD-II Hibrit Veri Füzyonu simülasyonu.',
                    style: semantics.textStyleCardBody,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.speed, color: semantics.textSecondary),
                  title: Text('Birimler', style: semantics.textStyleCardBody),
                  trailing: Text('Metrik (km/h, °C)', style: semantics.textStyleCardBody),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.color_lens, color: semantics.textSecondary),
                  title: Text('Tema', style: semantics.textStyleCardBody),
                  trailing: Text('Koyu Tema (Varsayılan)', style: semantics.textStyleCardBody),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 60,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
