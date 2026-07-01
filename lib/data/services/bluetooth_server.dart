import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'elm327_simulator.dart';

class BluetoothServer {
  final Elm327Simulator simulator;
  final Function(String)? onLog;
  static const MethodChannel _channel = MethodChannel('com.preditech.ecu/bluetooth_server');
  static const EventChannel _eventChannel = EventChannel('com.preditech.ecu/bluetooth_events');
  
  StreamSubscription? _eventSubscription;
  bool _isRunning = false;
  String _receiveBuffer = ''; 

  BluetoothServer({required this.simulator, this.onLog});

  bool get isRunning => _isRunning;

  Future<bool> startServer() async {
    if (Platform.isWindows) {
      onLog?.call("Bluetooth sunucusu Windows üzerinde desteklenmiyor. Lütfen Wi-Fi seçeneğini kullanın.");
      return false;
    }
    try {
      final bool? result = await _channel.invokeMethod('startServer');
      if (result == true) {
        _isRunning = true;
        
        _eventSubscription = _eventChannel.receiveBroadcastStream().listen(
          (dynamic event) {
            if (event is String) {
              if (event.startsWith("ClientConnected")) {
                 onLog?.call("İstemci bağlandı (Bluetooth).");
              } else if (event.startsWith("ClientDisconnected")) {
                 onLog?.call("İstemci bağlantıyı kesti (Bluetooth).");
              } else {
                 _handleData(event);
              }
            }
          },
          onError: (error) {
            debugPrint("BT Event Stream Error: $error");
            onLog?.call("Bluetooth Hatası: $error");
          }
        );
        debugPrint("BT Server started via MethodChannel.");
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("BT Server start error: $e");
      onLog?.call("Bluetooth başlatma hatası: $e");
      return false;
    }
  }

  Future<void> _handleData(String data) async {
    _receiveBuffer += data;
    
    while (_receiveBuffer.contains('\r')) {
      int index = _receiveBuffer.indexOf('\r');
      String command = _receiveBuffer.substring(0, index);
      _receiveBuffer = _receiveBuffer.substring(index + 1);
      
      if (command.trim().isNotEmpty) {
        onLog?.call("Rx: $command");
        String response = await simulator.processCommand(command);
        _sendData(response);
      } else {
        _sendData(await simulator.processCommand(""));
      }
    }
  }

  Future<void> _sendData(String text) async {
    try {
      onLog?.call("Tx: ${text.trimRight()}");
      await _channel.invokeMethod('sendData', {'data': text});
    } catch (e) {
      debugPrint("BT send error: $e");
    }
  }

  Future<void> stopServer() async {
    try {
      await _eventSubscription?.cancel();
      _eventSubscription = null;
      await _channel.invokeMethod('stopServer');
      _isRunning = false;
      debugPrint("BT Server stopped.");
    } catch (e) {
      debugPrint("BT Server stop error: $e");
    }
  }
}
