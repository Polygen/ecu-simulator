import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'models/vehicle_profile_table.dart';
import 'models/dtc_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [VehicleProfiles, DtcCodes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.deleteTable(dtcCodes.actualTableName);
            await m.createTable(dtcCodes);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'preditech_ecu.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
