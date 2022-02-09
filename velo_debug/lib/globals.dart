library velo_debug.globals;

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

List<String> _receivedData = <String>[];
List<String> _formatted = <String>[];
String _finalData = "";
String _oldData = "";


void updateGlobal(String input) {
  List<String> temp = input.split(',');
  for (int i = 1; i < temp.length; i++) {
    _receivedData.add(temp[i]);
  }
  if (temp[0] == "FIN:") {
    _writeData();
  }
}

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