import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/providers.dart';
import '../../../data/local/database.dart';

final dtcViewModelProvider = StateNotifierProvider<DtcViewModel, List<DtcCode>>((ref) {
  final db = ref.watch(databaseProvider);
  return DtcViewModel(db);
});

class DtcViewModel extends StateNotifier<List<DtcCode>> {
  final AppDatabase _db;
  StreamSubscription? _subscription;

  DtcViewModel(this._db) : super([]) {
    _subscription = _db.select(_db.dtcCodes).watch().listen((dtcs) {
      state = dtcs;
    });
  }

  Future<void> addDtc(String code, String desc, String status, int profileId) async {
    await _db.into(_db.dtcCodes).insert(
      DtcCodesCompanion.insert(
        code: code,
        description: drift.Value(desc),
        status: drift.Value(status),
        profileId: profileId,
      )
    );
  }

  Future<void> removeDtc(int id) async {
    await (_db.delete(_db.dtcCodes)..where((t) => t.id.equals(id))).go();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
