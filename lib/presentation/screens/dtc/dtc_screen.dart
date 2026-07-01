import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../../viewmodels/dtc_viewmodel.dart';

class DtcScreen extends ConsumerWidget {
  const DtcScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semantics = context.pt;
    final dtcs = ref.watch(dtcViewModelProvider);

    return Scaffold(
      backgroundColor: semantics.background,
      appBar: AppBar(
        backgroundColor: semantics.surface,
        title: Text('Hata Kodları (DTC)', style: context.pt.textStyleCardTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dtcs.length,
        itemBuilder: (context, index) {
          final dtc = dtcs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: semantics.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: semantics.borderDefault),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: semantics.statusDanger.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dtc.code,
                    style: context.pt.textStyleCardTitle.copyWith(
                      color: semantics.statusDanger,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dtc.description ?? 'Açıklama yok',
                        style: context.pt.textStyleCardBody,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dtc.status,
                        style: context.pt.textStyleCardBody.copyWith(
                          fontSize: 12,
                          color: semantics.statusWarning,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: semantics.statusDanger),
                  onPressed: () {
                    ref.read(dtcViewModelProvider.notifier).removeDtc(dtc.id);
                  },
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: semantics.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newCode = '';
              String newDesc = '';
              String status = 'Stored';
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: semantics.surface,
                    title: Text('Yeni DTC Ekle', style: context.pt.textStyleCardTitle),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Kod (örn: P0104)',
                            labelStyle: TextStyle(color: semantics.textSecondary),
                          ),
                          style: TextStyle(color: semantics.textPrimary),
                          onChanged: (val) => newCode = val,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Açıklama',
                            labelStyle: TextStyle(color: semantics.textSecondary),
                          ),
                          style: TextStyle(color: semantics.textPrimary),
                          onChanged: (val) => newDesc = val,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: status,
                          dropdownColor: semantics.surface,
                          style: TextStyle(color: semantics.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Durum',
                            labelStyle: TextStyle(color: semantics.textSecondary),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Stored', child: Text('Stored')),
                            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                            DropdownMenuItem(value: 'Permanent', child: Text('Permanent')),
                          ],
                          onChanged: (val) {
                            if (val != null) setState(() => status = val);
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('İptal', style: TextStyle(color: semantics.textSecondary)),
                      ),
                      PrimaryButton(
                        label: 'Ekle',
                        onPressed: () {
                          if (newCode.isNotEmpty) {
                            ref.read(dtcViewModelProvider.notifier).addDtc(newCode, newDesc, status, 1);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  );
                }
              );
            },
          );
        },
        icon: Icon(Icons.add, color: semantics.background),
        label: Text('DTC Ekle', style: TextStyle(color: semantics.background)),
      ),
    );
  }
}
