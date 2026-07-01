import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final semantics = context.pt;

    return Scaffold(
      backgroundColor: semantics.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/preditech_logo.png',
              width: 200,
            ),
            const SizedBox(height: 24),
            Text(
              'ECU SIMULATOR',
              style: context.pt.textStyleCardTitle.copyWith(
                color: semantics.primary,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
