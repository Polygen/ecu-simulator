import 'package:flutter/material.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../dashboard/dashboard_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final semantics = context.pt;

    return Scaffold(
      backgroundColor: semantics.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              PreditechIcon(
                PreditechIcons.carFill,
                size: 80,
                color: semantics.primary,
              ),
              const SizedBox(height: 32),
              Text(
                'Hoş Geldiniz',
                textAlign: TextAlign.center,
                style: context.pt.textStyleCardTitle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bu uygulama gerçek bir OBD-II tarayıcısı değildir.\n\nSadece yazılım geliştirme ve test amaçlı kullanılan bir ELM327 / ECU Simülatörüdür.',
                textAlign: TextAlign.center,
                style: context.pt.textStyleCardBody.copyWith(
                  fontSize: 16,
                  color: semantics.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: semantics.statusWarning.withAlpha(25), // ~10%
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: semantics.statusWarning.withAlpha(127)), // ~50%
                ),
                child: Row(
                  children: [
                    PreditechIcon(PreditechIcons.warning, color: semantics.statusWarning),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Araçlara bağlanmaz. Bluetooth veya Wi-Fi üzerinden diğer cihazlara veri yayınlar.',
                        style: context.pt.textStyleCardBody.copyWith(
                          color: semantics.statusWarning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Anladım, Simülatöre Geç',
                onPressed: () async {
                  await [
                    Permission.bluetooth,
                    Permission.bluetoothConnect,
                    Permission.bluetoothScan,
                    Permission.bluetoothAdvertise,
                    Permission.location,
                  ].request();

                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
