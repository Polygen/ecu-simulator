import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: PreditechEcuSimApp()));
}

class PreditechEcuSimApp extends StatelessWidget {
  const PreditechEcuSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preditech ECU Simulator',
      debugShowCheckedModeBanner: false,
      theme: PreditechTheme.dark(),
      home: const SplashScreen(),
    );
  }
}
