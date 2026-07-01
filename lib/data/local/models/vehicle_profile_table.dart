import 'package:drift/drift.dart';

@DataClassName('VehicleProfile')
class VehicleProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get vin => text()();
  TextColumn get make => text().nullable()();
  TextColumn get model => text().nullable()();
  IntColumn get year => integer().nullable()();
  IntColumn get odometer => integer().withDefault(const Constant(0))();
  
  // Custom PID values that belong to this profile
  IntColumn get defaultRpm => integer().withDefault(const Constant(800))();
  IntColumn get defaultSpeed => integer().withDefault(const Constant(0))();
}
