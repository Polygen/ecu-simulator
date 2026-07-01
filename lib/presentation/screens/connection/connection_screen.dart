import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preditech_ui_kit/preditech_ui_kit.dart';
import '../../../data/services/serial_server.dart';
import '../../viewmodels/connection_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ConnectionScreen extends ConsumerWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semantics = context.pt;
    final state = ref.watch(connectionProvider);
    final notifier = ref.read(connectionProvider.notifier);

    return Scaffold(
      backgroundColor: semantics.background,
      appBar: AppBar(
        backgroundColor: semantics.surface,
        title: Text('Bağlantı & Servisler', style: semantics.textStyleCardTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: semantics.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: semantics.borderDefault),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TypeSelector(
                          label: Platform.isWindows
                              ? 'COM Port (BT)'
                              : Platform.isLinux
                                  ? 'Bluetooth (rfcomm)'
                                  : 'Bluetooth',
                          icon: Icons.bluetooth,
                          isSelected: state.serverType == ServerType.bluetooth,
                          onTap: () => notifier.setServerType(ServerType.bluetooth),
                          ext: semantics,
                        ),
                        const SizedBox(width: 16),
                        _TypeSelector(
                          label: 'Wi-Fi',
                          icon: Icons.wifi,
                          isSelected: state.serverType == ServerType.wifi,
                          onTap: () => notifier.setServerType(ServerType.wifi),
                          ext: semantics,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (state.serverType == ServerType.bluetooth && (Platform.isWindows || Platform.isLinux))
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: semantics.statusWarning.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: semantics.statusWarning),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: semantics.statusWarning),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    Platform.isLinux
                                        ? 'Linux\'ta Bluetooth SPP için rfcomm kullanılır.\n1. bluez-deprecated-tools kurun: sudo pacman -S bluez-deprecated-tools\n2. Ayrı terminalde dinleyici başlatın: sudo rfcomm listen /dev/rfcomm0 1\n3. Oluşan /dev/rfcommX portunu aşağıdan seçin:'
                                        : 'Windows\'ta Bluetooth için Sanal COM port kullanın.\n1. Windows Ayarları > Bluetooth > Daha fazla Bluetooth seçeneği\n2. COM Bağlantı Noktaları > Ekle > Gelen (Incoming)\n3. Oluşan COM portunu buradan seçin:',
                                    style: TextStyle(color: semantics.statusWarning, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'COM Port Seçin',
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: semantics.background,
                              ),
                              dropdownColor: semantics.background,
                              value: state.selectedComPort,
                              items: SerialServer.availablePorts
                                  .where((port) => Platform.isWindows
                                      ? port.startsWith('COM')
                                      : port.startsWith('/dev/rfcomm'))
                                  .map((port) => DropdownMenuItem(
                                        value: port,
                                        child: Text(port, style: TextStyle(color: semantics.textPrimary)),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) notifier.setSelectedComPort(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    if (state.serverType == ServerType.wifi && state.localIp != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Cihazınızın IP Adresi: ${state.localIp}\nPort: 35000',
                          textAlign: TextAlign.center,
                          style: semantics.textStyleCardBody.copyWith(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: state.isRunning ? 'Sunucuyu Durdur' : 'Sunucuyu Başlat',
                      onPressed: () => notifier.toggleServer(),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bağlantı Logları', style: semantics.textStyleCardTitle),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20, color: Colors.white70),
                      onPressed: () {
                        if (state.logs.isNotEmpty) {
                          Clipboard.setData(ClipboardData(text: state.logs.join('\n')));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Loglar kopyalandı!')),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, size: 20, color: Colors.white70),
                      onPressed: () {
                        if (state.logs.isNotEmpty) {
                          Share.share(state.logs.join('\n'), subject: 'ECU Simulator Logs');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: semantics.borderDefault),
                ),
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: state.logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        state.logs[index],
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final PreditechSemanticThemeExtension ext;

  const _TypeSelector({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.ext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? ext.primary.withAlpha(25) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? ext.primary : ext.borderDefault,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? ext.primary : ext.textSecondary, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: ext.textStyleCardBody.copyWith(
                color: isSelected ? ext.primary : ext.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
