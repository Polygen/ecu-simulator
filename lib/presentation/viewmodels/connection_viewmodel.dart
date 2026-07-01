import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers.dart';
import '../../../data/services/bluetooth_server.dart';
import '../../../data/services/wifi_server.dart';
import '../../../data/services/serial_server.dart';

final connectionProvider = StateNotifierProvider<ConnectionViewModel, ConnectionState>((ref) {
  final simulator = ref.watch(elm327SimulatorProvider);
  late ConnectionViewModel viewModel;
  
  final btServer = BluetoothServer(
    simulator: simulator,
    onLog: (msg) => viewModel.addLog(msg),
  );
  
  final wifiServer = WifiServer(
    simulator: simulator,
    onLog: (msg) => viewModel.addLog(msg),
  );

  final serialServer = SerialServer(
    simulator: simulator,
    onLog: (msg) => viewModel.addLog(msg),
  );
  
  viewModel = ConnectionViewModel(btServer, wifiServer, serialServer);
  return viewModel;
});

enum ServerType { bluetooth, wifi }

class ConnectionState {
  final bool isRunning;
  final ServerType serverType;
  final List<String> logs;
  final String? localIp;
  final String? selectedComPort;

  ConnectionState({
    required this.isRunning,
    required this.serverType,
    required this.logs,
    this.localIp,
    this.selectedComPort,
  });

  ConnectionState copyWith({
    bool? isRunning,
    ServerType? serverType,
    List<String>? logs,
    String? localIp,
    String? selectedComPort,
  }) {
    return ConnectionState(
      isRunning: isRunning ?? this.isRunning,
      serverType: serverType ?? this.serverType,
      logs: logs ?? this.logs,
      localIp: localIp ?? this.localIp,
      selectedComPort: selectedComPort ?? this.selectedComPort,
    );
  }
}

class ConnectionViewModel extends StateNotifier<ConnectionState> {
  final BluetoothServer _btServer;
  final WifiServer _wifiServer;
  final SerialServer _serialServer;

  ConnectionViewModel(this._btServer, this._wifiServer, this._serialServer)
      : super(ConnectionState(
          isRunning: false,
          serverType: ServerType.bluetooth,
          logs: [],
        ));

  void setServerType(ServerType type) {
    if (state.isRunning) return; // Cannot change while running
    state = state.copyWith(serverType: type);
    if (type == ServerType.wifi) {
      _fetchLocalIp();
    }
  }

  void setSelectedComPort(String port) {
    if (state.isRunning) return;
    state = state.copyWith(selectedComPort: port);
  }

  Future<void> _fetchLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      for (var interface in interfaces) {
        if (interface.name.toLowerCase().contains('wlan') || 
            interface.name.toLowerCase().contains('wi-fi') || 
            interface.name.toLowerCase().contains('eth') || 
            interface.name.toLowerCase().contains('en')) {
          for (var addr in interface.addresses) {
            if (!addr.isLoopback) {
               state = state.copyWith(localIp: addr.address);
               return;
            }
          }
        }
      }
      // Fallback
      if (interfaces.isNotEmpty && interfaces.first.addresses.isNotEmpty) {
         state = state.copyWith(localIp: interfaces.first.addresses.first.address);
      }
    } catch (e) {
       addLog("IP Getirilemedi: $e");
    }
  }

  void addLog(String message) {
    final newLogs = List<String>.from(state.logs)..add('${DateTime.now().toIso8601String().substring(11, 23)} - $message');
    if (newLogs.length > 2000) newLogs.removeAt(0); // Yaklaşık 2000 satır limit
    state = state.copyWith(logs: newLogs);
  }

  Future<void> toggleServer() async {
    if (state.isRunning) {
      if (state.serverType == ServerType.bluetooth) {
        if (Platform.isWindows) {
          _serialServer.stopServer();
        } else {
          await _btServer.stopServer();
        }
      } else {
        _wifiServer.stopServer();
      }
      state = state.copyWith(isRunning: false);
      addLog("Sunucu durduruldu.");
    } else {
      bool success = false;
      if (state.serverType == ServerType.bluetooth) {
        if (Platform.isWindows) {
           if (state.selectedComPort == null) {
              addLog("Hata: Lütfen bir COM portu seçin.");
              return;
           }
           addLog("COM Port (${state.selectedComPort}) Sunucusu başlatılıyor...");
           success = await _serialServer.startServer(state.selectedComPort!);
        } else {
           addLog("Bluetooth Sunucusu başlatılıyor...");
           success = await _btServer.startServer();
        }
      } else {
        addLog("Wi-Fi Sunucusu başlatılıyor...");
        if (state.localIp == null) {
          await _fetchLocalIp();
        }
        success = await _wifiServer.startServer();
      }

      if (success) {
        state = state.copyWith(isRunning: true);
        addLog("Sunucu başarıyla başlatıldı.");
      } else {
        addLog("Hata: Sunucu başlatılamadı.");
      }
    }
  }
}
