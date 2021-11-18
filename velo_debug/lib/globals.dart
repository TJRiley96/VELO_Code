library velo_debug.globals;

import 'dart:io';

import 'package:path_provider/path_provider.dart';

List<String> BLEData;
void updateGlobal(String input){
    List<String> temp = input.split(',');
    for(int i = 1; temp.length-1; i++){
        BLEData[i] = input[i];
    }
    _writeData(BLEData);
}
Future<String> _getDirPath() async {
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
}
Future<void> _writeData(var input) async {
    final _dirPath = await _getDirPath();
    print('$_dirPath');
    final _myFile = File('$_dirPath/testData.txt');
    // If data.txt doesn't exist, it will be created automatically
    print('File Updated!');
    await _myFile.writeAsString('$input\n',mode: FileMode.append);
}