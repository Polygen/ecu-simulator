import 'dart:async';
import '../local/database.dart';

class Elm327Simulator {
  final AppDatabase database;
  
  Elm327Simulator({required this.database});

  bool _echoOn = true;
  bool _headersOn = true;
  bool _linefeedsOn = true;
  bool _spacesOn = true;
  
  // Custom PID values
  int _rpm = 800;
  int _speed = 0;
  int _coolantTemp = 110;
  int _maf = 10;
  int _map = 30;
  int _throttle = 15;
  double _voltage = 13.8;
  
  void updateRpm(int rpm) {
    _rpm = rpm;
  }
  
  void updateSpeed(int speed) {
    _speed = speed;
  }

  void updateState({int? maf, int? map, int? throttle, double? voltage}) {
    if (maf != null) _maf = maf;
    if (map != null) _map = map;
    if (throttle != null) _throttle = throttle;
    if (voltage != null) _voltage = voltage;
  }

  Future<String> processCommand(String command) async {
    command = command.trim().toUpperCase();
    if (command.isEmpty) return '>';
    
    String suffix = _linefeedsOn ? '\r\n>' : '\r>';
    String prefix = _echoOn ? '$command\r' : '';
    String response = '';

    if (command.startsWith('AT')) {
      response = _handleAtCommand(command);
    } else {
      response = await _handleObdCommand(command);
    }
    
    if (response.isEmpty) {
       return '$prefix$suffix';
    }
    return '$prefix$response$suffix';
  }

  int _protocol = 6; // Default to CAN 11/500

  String _handleAtCommand(String cmd) {
    if (cmd.startsWith('ATSP') || cmd.startsWith('ATTP')) {
      String p = cmd.substring(4);
      if (p.isNotEmpty) {
        int? val = int.tryParse(p);
        if (val != null) {
           if (val == 0) _protocol = 6; // Auto usually picks CAN
           else _protocol = val;
        }
      }
      return 'OK';
    }
    
    switch (cmd) {
      case 'ATZ':
      case 'ATWS':
        _echoOn = true;
        _headersOn = true;
        _linefeedsOn = true;
        _spacesOn = true;
        _protocol = 6; // Reset
        return 'ELM327 v1.5';
      case 'ATE0':
        _echoOn = false;
        return 'OK';
      case 'ATE1':
        _echoOn = true;
        return 'OK';
      case 'ATH0':
        _headersOn = false;
        return 'OK';
      case 'ATH1':
        _headersOn = true;
        return 'OK';
      case 'ATL0':
        _linefeedsOn = false;
        return 'OK';
      case 'ATL1':
        _linefeedsOn = true;
        return 'OK';
      case 'ATS0':
        _spacesOn = false;
        return 'OK';
      case 'ATS1':
        _spacesOn = true;
        return 'OK';
      case 'ATST':
      case 'ATAT1':
      case 'ATAT2':
      case 'ATCAF0':
      case 'ATCAF1':
      case 'ATSH7E0':
        return 'OK';
      case 'ATDP':
        if (_protocol == 5) return 'ISO 14230-4 (KWP FAST)';
        if (_protocol == 4) return 'ISO 14230-4 (KWP 5BAUD)';
        if (_protocol == 3) return 'ISO 9141-2';
        return 'ISO 15765-4 (CAN 11/500)';
      case 'ATDPN':
        return '$_protocol';
      case 'ATRV': 
        return '${_voltage.toStringAsFixed(1)}V';
      default:
        return 'OK'; 
    }
  }

  String _formatResponse(String header, String length, String data) {
    String res = "";
    if (_headersOn) {
        res += header;
        if (_spacesOn) res += " ";
        res += length;
        if (_spacesOn) res += " ";
    }
    
    List<String> bytes = data.split(' ');
    if (_spacesOn) {
       res += bytes.join(' ');
    } else {
       res += bytes.join('');
    }
    return res;
  }

  Future<String> _handleObdCommand(String cmd) async {
    if (cmd.startsWith('01')) {
      String cleanCmd = cmd.replaceAll(' ', '');
      if (cleanCmd.length >= 4) {
         String pid = cleanCmd.substring(2, 4);
         return await _handleMode01(pid);
      }
      return 'NO DATA';
    }
    else if (cmd.startsWith('03') || cmd.startsWith('07') || cmd.startsWith('0A')) {
      String statusFilter = 'Stored';
      if (cmd.startsWith('07')) statusFilter = 'Pending';
      else if (cmd.startsWith('0A')) statusFilter = 'Permanent';

      final allDtcs = await database.select(database.dtcCodes).get();
      final dtcs = allDtcs.where((d) => d.status == statusFilter).toList();
      
      String responsePrefix = '4${cmd.substring(1, 2)}'; // 43, 47, 4A
      
      if (dtcs.isEmpty) {
        return _formatResponse('7E8', '02', '$responsePrefix 00');
      }
      
      List<String> hexCodes = [];
      for (var dtc in dtcs) {
         if (dtc.code.length == 5) {
            String c1 = dtc.code[0].toUpperCase();
            int b1 = 0;
            if (c1 == 'C') b1 = 0x40;
            else if (c1 == 'B') b1 = 0x80;
            else if (c1 == 'U') b1 = 0xC0;
            
            int c2 = int.tryParse(dtc.code[1]) ?? 0;
            b1 = b1 | (c2 << 4);
            int c3 = int.tryParse(dtc.code[2]) ?? 0;
            b1 = b1 | c3;
            
            String b2Hex = dtc.code.substring(3,5);
            hexCodes.add(b1.toRadixString(16).padLeft(2, '0').toUpperCase() + " " + b2Hex);
         }
      }
      
      String hexDtcs = hexCodes.join(' ');
      String countHex = dtcs.length.toRadixString(16).padLeft(2, '0').toUpperCase();
      
      int totalBytes = 2 + hexCodes.length * 2; // 1 for Service + 1 for Count + 2 per DTC
      String lengthHex = totalBytes.toRadixString(16).padLeft(2, '0').toUpperCase();
      
      return _formatResponse('7E8', lengthHex, '$responsePrefix $countHex $hexDtcs');
    }
    else if (cmd.startsWith('04')) {
      await database.delete(database.dtcCodes).go();
      return _formatResponse('7E8', '01', '44');
    }
    else if (cmd.startsWith('09')) {
      String pid = cmd.replaceAll(' ', '').substring(2);
      if (pid == '02') {
        final profiles = await database.select(database.vehicleProfiles).get();
        String vin = "1HGCGD12345678901"; 
        if (profiles.isNotEmpty) {
           vin = profiles.first.vin;
        }
        vin = vin.padRight(17, '0').substring(0, 17);
        String hexVin = vin.codeUnits.map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(' ');
        return _formatResponse('7E8', '14', '49 02 01 $hexVin');
      }
      return 'NO DATA';
    }
    
    return 'NO DATA';
  }

  Future<String> _handleMode01(String pid) async {
    switch (pid) {
      case '00': 
        return _formatResponse('7E8', '06', '41 00 BE 1F A8 13');
      case '01': 
        final dtcs = await database.select(database.dtcCodes).get();
        int count = dtcs.length;
        int a = (count > 0) ? (0x80 | (count & 0x7F)) : 0x00;
        String hexA = a.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '06', '41 01 $hexA 07 65 00');
      case '0C': 
        int a = _rpm * 4 ~/ 256;
        int b = (_rpm * 4) % 256;
        String hexA = a.toRadixString(16).padLeft(2, '0').toUpperCase();
        String hexB = b.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '04', '41 0C $hexA $hexB');
      case '0D': 
        String hexSpeed = _speed.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '03', '41 0D $hexSpeed');
      case '05': 
        int tempVal = _coolantTemp + 40;
        String hexTemp = tempVal.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '03', '41 05 $hexTemp');
      case '10': 
        int mafVal = _maf * 100;
        String hexMafA = (mafVal ~/ 256).toRadixString(16).padLeft(2, '0').toUpperCase();
        String hexMafB = (mafVal % 256).toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '04', '41 10 $hexMafA $hexMafB');
      case '0B': 
        String hexMap = _map.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '03', '41 0B $hexMap');
      case '11': 
        int tpVal = (_throttle * 255) ~/ 100;
        String hexTp = tpVal.toRadixString(16).padLeft(2, '0').toUpperCase();
        return _formatResponse('7E8', '03', '41 11 $hexTp');
      case '2F': 
        return _formatResponse('7E8', '03', '41 2F EE');
      case '33': 
        return _formatResponse('7E8', '03', '41 33 AE');
      case '46': 
        return _formatResponse('7E8', '03', '41 46 55');
      case '5C': 
        return _formatResponse('7E8', '03', '41 5C 64');
      case '42': 
        return _formatResponse('7E8', '04', '41 42 3C 14');
      default:
        return 'NO DATA';
    }
  }
}
