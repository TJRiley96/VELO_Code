library velo_debug.globals;

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

List<String> _receivedData = <String>[];
List<String> _formatted = <String>[];


void updateGlobal(String input) {
  List<String> temp = input.split(',');
  for (int i = 1; i < temp.length; i++) {
    _receivedData.add(temp[i]);
  }
  if (temp[0] == "1:") {
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
  await _myFile.writeAsString(_formatted.join(',').toString(), mode: FileMode.append, encoding: utf8);
  _receivedData.clear();
}
