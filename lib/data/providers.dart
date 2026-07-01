import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/database.dart';
import 'services/elm327_simulator.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final elm327SimulatorProvider = Provider<Elm327Simulator>((ref) {
  final db = ref.watch(databaseProvider);
  return Elm327Simulator(database: db);
});
