library velo_debug.globals;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:path_provider/path_provider.dart';

List<String> _receivedData = <String>[];
List<String> _formatted = <String>[];
String _finalData = "";
String _oldData = "";
bool connected = false;
const List<List<int>> ColorSchemeData = [[0xFFFFE8D6, 0xFF15232B, 0xFFFF4D19],[0xFFF5F4DA, 0xFF1B1B29, 0xFFB1B025]];
int _color = 0;
DateTime now = new DateTime.now();
DateTime date = new DateTime(now.year, now.month, now.day);
String filename = "${date.year}-${date.month}-${date.day}";
Future<List<List<double>>> try2 = loadGraph();

List<BluetoothDevice> devices = [];

void initializeGlobals(){
  _readColor();
}
void setConnected(bool b){connected = b;}
bool getConnected(){return connected;}
void setDevice(BluetoothDevice d) => devices.insert(0, d);
void deleteDevice() => devices.clear();

Future<bool> isConnected() async{
  //print("Device State: ${devices[0].state}      ==================================================");
  print(devices);
  if(devices.isEmpty){
    print("Device is empty");
    print("Device not Connected");
    return false;
  }else if(devices[0].state == BluetoothDeviceState.connected){
    print("Device Connected");
    return true;
  } else{
    print("Device has disconnected");
    print("Device not Connected");
    deleteDevice();
    return false;
  }
}
BluetoothDevice getDevice() {return devices.first;}
void updateGlobal(String input) {
  List<String> temp = input.split(',');
  for (int i = 1; i < temp.length; i++) {
    _receivedData.add(temp[i]);
  }
  if (temp[0] == "FIN:") {
    _writeData();
  }
}

Future<void> writeColor(int colorNum){
  final _path  = _getDirPath();
  final _myFile = File('$_path/color.txt');
  return _myFile.writeAsString('$colorNum');
}

Future<void> _readColor() async{
  final _path  = _getDirPath();
  if(File('$_path/color.txt').existsSync()){
    final _myFile = File('$_path/color.txt');
    final contents = await _myFile.readAsString();
    _color = int.parse(contents);
  }else{
    final _myFile = File('$_path/color.txt');
    _myFile.writeAsString('0');
    _color = 0;
  }

}
Future<int> getColor() async => _color;
Future<List<String>> getData() async{return _formatted;}
Future<String> _getDirPath() async {
  final _dir = await getApplicationDocumentsDirectory();
  return _dir.path;
}

Future<void> _writeData() async {
  final _dirPath = await _getDirPath();
  print('$_dirPath');
  final _myFile = File('$_dirPath/testData.txt');
  // If data.txt doesn't exist, it will be created automatically
  _formatted = _receivedData;
  print('File Updated!');
  print(_formatted.join(',').toString());
  String _output = _formatted.join(',').toString() + "\n";
  _finalData = _formatted.join(',').toString();
  await _myFile.writeAsString( _output, mode: FileMode.append, encoding: utf8);
  _formatted.clear();
  _receivedData.clear();
}
Future<List<List<double>>> loadGraph() async {
  List<List<double>> data = [];
  List<String> readIn;

  final _dirPath = await _getDirPath();
  //if(!File('$_dirPath/$filename.txt').existsSync()){ print("File Doesn't Exist!!"); return data;}
  final _myFile = File('$_dirPath/$filename.txt');
  readIn = await _myFile.readAsLines(encoding: utf8);
  print(readIn);
  readIn.forEach((e) {
    List<double> send = [];
     List<String> con = e.split(',');
     con.forEach((element) {send.add(double.parse(element)); });
     print(send);
     data.add(send);
  });
  return data;
}
Future<void> appendFile(double index, double acl, double ori, double flex) async {
  final _dirPath = await _getDirPath();
  print('$_dirPath');
  var toFile = [index, acl, ori, flex];
  final _myFile = File('$_dirPath/$filename.txt');
  await _myFile.writeAsString( toFile.join(',').toString() + "\n", mode: FileMode.append, encoding: utf8);
  toFile.clear();

}
List<String> parseData(String data){
  List<String> parsed;
  parsed = data.split(',');
  return parsed;
}

String getStringData(){

  if(_finalData == "" || _finalData.split(',').length < 6){
    return _oldData;
  }else{
    _oldData = _finalData;

    return _finalData;
  }
}