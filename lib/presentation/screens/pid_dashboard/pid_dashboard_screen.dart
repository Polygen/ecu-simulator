import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../../viewmodels/simulator_viewmodel.dart';

class PidDashboardScreen extends ConsumerWidget {
  const PidDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulatorState = ref.watch(simulatorProvider);
    final simulatorNotifier = ref.read(simulatorProvider.notifier);
    final semantics = context.pt;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Canlı Veri Yayını',
                style: context.pt.textStyleCardTitle,
              ),
              Switch(
                value: simulatorState.isEngineRunning,
                onChanged: (_) => simulatorNotifier.toggleEngine(),
                activeTrackColor: semantics.primary.withAlpha(100),
                activeColor: semantics.primary, // Using activeTrackColor and activeColor
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Top Row: Speed and RPM
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GaugeSquareCard(
                  value: simulatorState.speed.toDouble(),
                  maxValue: 240,
                  gaugeLabel: 'Hız',
                  gaugeUnit: 'km/h',
                  bottomLabel: 'Hız',
                  bottomValue: '${simulatorState.speed} km/h',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GaugeSquareCard(
                  value: simulatorState.rpm.toDouble(),
                  maxValue: 8000,
                  gaugeLabel: 'Devir',
                  gaugeUnit: 'RPM',
                  bottomLabel: 'Devir',
                  bottomValue: '${simulatorState.rpm} RPM',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom Row: MAF, MAP, Throttle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GaugeSquareCard(
                  value: simulatorState.maf.toDouble(),
                  maxValue: 200,
                  gaugeLabel: 'MAF',
                  gaugeUnit: 'g/s',
                  bottomLabel: 'Kütle Hava',
                  bottomValue: '${simulatorState.maf} g/s',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GaugeSquareCard(
                  value: simulatorState.map.toDouble(),
                  maxValue: 255,
                  gaugeLabel: 'MAP',
                  gaugeUnit: 'kPa',
                  bottomLabel: 'Manifold',
                  bottomValue: '${simulatorState.map} kPa',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GaugeSquareCard(
                  value: simulatorState.throttlePosition.toDouble(),
                  maxValue: 100,
                  gaugeLabel: 'Açı',
                  gaugeUnit: '%',
                  bottomLabel: 'Gaz Kelebeği',
                  bottomValue: '${simulatorState.throttlePosition} %',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: semantics.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: semantics.borderDefault),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Manuel Kontroller', style: semantics.textStyleCardTitle),
                const SizedBox(height: 16),
                Text('Araç Hızı (km/h)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.speed.toDouble(),
                  min: 0,
                  max: 240,
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setSpeed(val.toInt())
                      : null,
                ),
                const SizedBox(height: 8),
                Text('Motor Devri (RPM)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.rpm.toDouble(),
                  min: 0,
                  max: 8000,
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setRpm(val.toInt())
                      : null,
                ),
                const SizedBox(height: 8),
                Text('Hava Akışı (MAF - g/s)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.maf.toDouble(),
                  min: 0,
                  max: 200,
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setMaf(val.toInt())
                      : null,
                ),
                const SizedBox(height: 8),
                Text('Manifold Basıncı (MAP - kPa)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.map.toDouble(),
                  min: 0,
                  max: 255,
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setMap(val.toInt())
                      : null,
                ),
                const SizedBox(height: 8),
                Text('Gaz Kelebeği (Throttle - %)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.throttlePosition.toDouble(),
                  min: 0,
                  max: 100,
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setThrottle(val.toInt())
                      : null,
                ),
                const SizedBox(height: 8),
                Text('Akü Voltajı (V)', style: semantics.textStyleCardBody),
                Slider(
                  value: simulatorState.voltage,
                  min: 10.0,
                  max: 15.0,
                  divisions: 50,
                  label: '${simulatorState.voltage.toStringAsFixed(1)} V',
                  activeColor: semantics.primary,
                  onChanged: simulatorState.isEngineRunning
                      ? (val) => simulatorNotifier.setVoltage(val)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
