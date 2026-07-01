import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'elm327_simulator.dart';

class WifiServer {
  final Elm327Simulator simulator;
  final Function(String)? onLog;
  ServerSocket? _serverSocket;
  final List<Socket> _clients = [];
  bool _isRunning = false;

  WifiServer({required this.simulator, this.onLog});

  bool get isRunning => _isRunning;

  Future<bool> startServer() async {
    try {
      _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 35000);
      _isRunning = true;
      debugPrint("Wi-Fi Server started on port 35000");
      onLog?.call("Wi-Fi sunucusu 35000 portunda dinliyor...");

      _serverSocket!.listen((Socket client) {
        _clients.add(client);
        debugPrint("WiFi Client connected: ${client.remoteAddress.address}");
        onLog?.call("İstemci bağlandı: ${client.remoteAddress.address}");
        String receiveBuffer = '';
        
        client.listen(
          (List<int> data) async {
            receiveBuffer += ascii.decode(data);
            while (receiveBuffer.contains('\r')) {
              int index = receiveBuffer.indexOf('\r');
              String command = receiveBuffer.substring(0, index);
              receiveBuffer = receiveBuffer.substring(index + 1);
              
              if (command.trim().isNotEmpty) {
                onLog?.call("Rx: $command");
                String response = await simulator.processCommand(command);
                _sendData(client, response);
              } else {
                _sendData(client, await simulator.processCommand(""));
              }
            }
          },
          onDone: () {
            debugPrint("WiFi Client disconnected");
            onLog?.call("İstemci bağlantıyı kesti.");
            _clients.remove(client);
            client.destroy();
          },
          onError: (error) {
            debugPrint("WiFi Client Error: $error");
            onLog?.call("İstemci hatası: $error");
            _clients.remove(client);
            client.destroy();
          }
        );
      });
      return true;
    } catch (e) {
      debugPrint("WiFi Server Error: $e");
      onLog?.call("Sunucu hatası: $e");
      return false;
    }
  }

  void _sendData(Socket client, String text) {
    try {
      onLog?.call("Tx: ${text.trimRight()}");
      client.write(text);
    } catch (e) {
      debugPrint("WiFi send error: $e");
    }
  }

  void stopServer() {
    for (var client in _clients) {
      client.close();
    }
    _clients.clear();
    _serverSocket?.close();
    _isRunning = false;
    debugPrint("WiFi Server stopped");
  }
}
