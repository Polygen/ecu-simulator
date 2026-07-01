import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers.dart';
import '../../../data/services/elm327_simulator.dart';

final simulatorProvider = StateNotifierProvider<SimulatorViewModel, SimulatorState>((ref) {
  return SimulatorViewModel(ref.watch(elm327SimulatorProvider));
});

class SimulatorState {
  final int rpm;
  final int speed;
  final int coolantTemp;
  final int maf;
  final int map;
  final int throttlePosition;
  final double voltage;
  final bool isEngineRunning;

  SimulatorState({
    required this.rpm,
    required this.speed,
    required this.coolantTemp,
    required this.maf,
    required this.map,
    required this.throttlePosition,
    required this.voltage,
    required this.isEngineRunning,
  });

  SimulatorState copyWith({
    int? rpm,
    int? speed,
    int? coolantTemp,
    int? maf,
    int? map,
    int? throttlePosition,
    double? voltage,
    bool? isEngineRunning,
  }) {
    return SimulatorState(
      rpm: rpm ?? this.rpm,
      speed: speed ?? this.speed,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      maf: maf ?? this.maf,
      map: map ?? this.map,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      voltage: voltage ?? this.voltage,
      isEngineRunning: isEngineRunning ?? this.isEngineRunning,
    );
  }
}

class SimulatorViewModel extends StateNotifier<SimulatorState> {
  final Elm327Simulator _simulator;
  Timer? _tickTimer;

  SimulatorViewModel(this._simulator)
      : super(SimulatorState(
          rpm: 800,
          speed: 0,
          coolantTemp: 110,
          maf: 10,
          map: 30,
          throttlePosition: 15,
          voltage: 13.8,
          isEngineRunning: true,
        )) {
    _startSimulation();
  }

  void _startSimulation() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!state.isEngineRunning) return;
      
      // Auto-fluctuations based on idle or speed
      int newRpm = state.rpm;
      if (state.speed == 0 && state.rpm <= 850 && state.rpm >= 750) {
        // Idle fluctuation
        newRpm = 800 + (DateTime.now().millisecondsSinceEpoch % 50);
      }
      
      // Add small noise to other sensors instead of strictly deriving them
      int noise = (DateTime.now().millisecondsSinceEpoch % 3) - 1;
      int newMaf = (state.maf + noise).clamp(0, 200).toInt();
      int newMap = (state.map + noise).clamp(0, 255).toInt();
      int newThrottle = (state.throttlePosition + noise).clamp(0, 100).toInt();

      state = state.copyWith(
        rpm: newRpm,
        maf: newMaf,
        map: newMap,
        throttlePosition: newThrottle,
      );
      
      // Sync with simulator backend
      _simulator.updateRpm(state.rpm);
      _simulator.updateSpeed(state.speed);
      _simulator.updateState(maf: state.maf, map: state.map, throttle: state.throttlePosition, voltage: state.voltage);
    });
  }

  void setRpm(int rpm) {
    state = state.copyWith(rpm: rpm);
    _simulator.updateRpm(rpm);
  }

  void setSpeed(int speed) {
    state = state.copyWith(speed: speed);
    _simulator.updateSpeed(speed);
  }

  void setMaf(int maf) {
    state = state.copyWith(maf: maf);
    _simulator.updateState(maf: maf, map: state.map, throttle: state.throttlePosition);
  }

  void setMap(int map) {
    state = state.copyWith(map: map);
    _simulator.updateState(maf: state.maf, map: map, throttle: state.throttlePosition);
  }

  void setThrottle(int throttle) {
    state = state.copyWith(throttlePosition: throttle);
    _simulator.updateState(maf: state.maf, map: state.map, throttle: throttle, voltage: state.voltage);
  }

  void setVoltage(double voltage) {
    state = state.copyWith(voltage: voltage);
    _simulator.updateState(maf: state.maf, map: state.map, throttle: state.throttlePosition, voltage: voltage);
  }

  void toggleEngine() {
    final running = !state.isEngineRunning;
    state = state.copyWith(
      isEngineRunning: running,
      rpm: running ? 800 : 0,
      speed: running ? state.speed : 0,
    );
    _simulator.updateRpm(state.rpm);
    _simulator.updateSpeed(state.speed);
    _simulator.updateState(maf: state.maf, map: state.map, throttle: state.throttlePosition, voltage: state.voltage);
  }

  Future<String> processCommand(String command) async {
    return await _simulator.processCommand(command);
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}
