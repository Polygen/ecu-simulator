import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'elm327_simulator.dart';

class SerialServer {
  final Elm327Simulator simulator;
  final Function(String)? onLog;
  SerialPort? _port;
  SerialPortReader? _reader;
  bool _isRunning = false;
  
  SerialServer({required this.simulator, this.onLog});

  bool get isRunning => _isRunning;

  static List<String> get availablePorts => SerialPort.availablePorts;

  Future<bool> startServer(String portName) async {
    try {
      _port = SerialPort(portName);
      
      if (!_port!.openReadWrite()) {
         debugPrint("Failed to open port: ${SerialPort.lastError}");
         onLog?.call("Port açılamadı: $portName");
         return false;
      }
      
      SerialPortConfig config = _port!.config;
      config.baudRate = 38400; // Common for ELM327 Bluetooth SPP
      _port!.config = config;

      _isRunning = true;
      debugPrint("Serial Server started on $portName");
      onLog?.call("COM Port ($portName) üzerinden dinleniyor...");

      String receiveBuffer = '';

      // Virtual Bluetooth COM ports on Windows often fail to trigger async events
      // used by SerialPortReader. We use manual polling instead.
      Timer.periodic(const Duration(milliseconds: 50), (timer) async {
        if (!_isRunning) {
          timer.cancel();
          return;
        }
        if (_port != null && _port!.isOpen) {
          try {
            Uint8List bytes = _port!.read(1024, timeout: -1); // -1 means return immediately
            if (bytes.isNotEmpty) {
              receiveBuffer += ascii.decode(bytes, allowInvalid: true);
              while (receiveBuffer.contains('\r')) {
                int index = receiveBuffer.indexOf('\r');
                String command = receiveBuffer.substring(0, index);
                receiveBuffer = receiveBuffer.substring(index + 1);
                
                if (command.trim().isNotEmpty) {
                  onLog?.call("Rx: $command");
                  String response = await simulator.processCommand(command);
                  _sendData(response);
                } else {
                  _sendData(await simulator.processCommand(""));
                }
              }
            }
          } catch (e) {
             debugPrint("Serial read error: $e");
             // Don't kill server on read timeout, just log once if critical
          }
        }
      });

      return true;
    } catch (e) {
      debugPrint("Serial Server Error: $e");
      onLog?.call("Sunucu hatası: $e");
      return false;
    }
  }

  void _sendData(String text) {
    try {
      onLog?.call("Tx: ${text.trimRight()}");
      _port?.write(Uint8List.fromList(ascii.encode(text)), timeout: 100);
    } catch (e) {
      debugPrint("Serial send error: $e");
    }
  }

  void stopServer() {
    _isRunning = false;
    if (_port != null && _port!.isOpen) {
       _port!.close();
    }
    _port?.dispose();
    _port = null;
    debugPrint("Serial Server stopped");
    onLog?.call("COM Port bağlantısı kapatıldı.");
  }
}
