import 'package:drift/drift.dart';
import 'vehicle_profile_table.dart';

@DataClassName('DtcCode')
class DtcCodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()(); // e.g. "P0104"
  TextColumn get description => text().nullable()();
  
  // Status: Stored, Pending, Permanent
  TextColumn get status => text().withDefault(const Constant('Stored'))();
  
  // Which profile this DTC belongs to
  IntColumn get profileId => integer().references(VehicleProfiles, #id)();
}
