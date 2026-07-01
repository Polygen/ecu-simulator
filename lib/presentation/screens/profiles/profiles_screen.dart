import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/providers.dart';
import '../../../data/local/database.dart';

final profilesStreamProvider = StreamProvider<List<VehicleProfile>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.vehicleProfiles).watch();
});

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  void _showAddProfileDialog(BuildContext context, WidgetRef ref, PreditechSemanticThemeExtension semantics) {
    final nameController = TextEditingController();
    final vinController = TextEditingController();
    String selectedProtocol = 'ISO 15765-4 CAN (11 bit ID, 500 kbaud)';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: semantics.surface,
              title: Text('Yeni Profil Ekle', style: semantics.textStyleCardTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      style: semantics.textStyleCardBody,
                      decoration: InputDecoration(
                        labelText: 'Profil Adı',
                        labelStyle: TextStyle(color: semantics.textSecondary),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: semantics.borderDefault)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: semantics.primary)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: vinController,
                      style: semantics.textStyleCardBody,
                      decoration: InputDecoration(
                        labelText: 'Araç Şasi Numarası (VIN)',
                        hintText: '17 haneli VIN girin',
                        hintStyle: TextStyle(color: semantics.borderDefault),
                        labelStyle: TextStyle(color: semantics.textSecondary),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: semantics.borderDefault)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: semantics.primary)),
                      ),
                      maxLength: 17,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedProtocol,
                      dropdownColor: semantics.surface,
                      style: semantics.textStyleCardBody,
                      decoration: InputDecoration(
                        labelText: 'OBD Protokolü',
                        labelStyle: TextStyle(color: semantics.textSecondary),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: semantics.borderDefault)),
                      ),
                      items: [
                        'ISO 15765-4 CAN (11 bit ID, 500 kbaud)',
                        'ISO 14230-4 KWP (fast init)',
                        'ISO 9141-2 (5 baud init)',
                        'SAE J1850 VPW'
                      ].map((p) => DropdownMenuItem(value: p, child: Text(p, style: TextStyle(fontSize: 12)))).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedProtocol = val!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('İptal', style: TextStyle(color: semantics.textSecondary)),
                ),
                PrimaryButton(
                  label: 'Kaydet',
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      final db = ref.read(databaseProvider);
                      await db.into(db.vehicleProfiles).insert(
                        VehicleProfilesCompanion.insert(
                          name: nameController.text,
                          make: drift.Value(selectedProtocol),
                          vin: vinController.text.isEmpty ? '1HGCV123456789012' : vinController.text,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semantics = context.pt;
    final profilesAsync = ref.watch(profilesStreamProvider);

    return Scaffold(
      backgroundColor: semantics.background,
      appBar: AppBar(
        backgroundColor: semantics.surface,
        title: Text('Araç Profilleri & VIN', style: semantics.textStyleCardTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: profilesAsync.when(
                data: (profiles) {
                  if (profiles.isEmpty) {
                    return Center(
                      child: Text('Kayıtlı profil bulunamadı.', style: semantics.textStyleCardBody),
                    );
                  }
                  return ListView.builder(
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      return Card(
                        color: semantics.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: semantics.borderDefault),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.directions_car, color: semantics.primary),
                          title: Text(profile.name, style: semantics.textStyleCardTitle),
                          subtitle: Text('VIN: ${profile.vin}\nProtokol: ${profile.make ?? "Belirtilmemiş"}', style: semantics.textStyleCardBody.copyWith(fontSize: 12)),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () async {
                              final db = ref.read(databaseProvider);
                              await (db.delete(db.vehicleProfiles)..where((tbl) => tbl.id.equals(profile.id))).go();
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Hata: $e')),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Yeni Profil Ekle',
              onPressed: () => _showAddProfileDialog(context, ref, semantics),
            ),
          ],
        ),
      ),
    );
  }
}
