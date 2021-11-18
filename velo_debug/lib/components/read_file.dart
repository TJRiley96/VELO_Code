import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Reading{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/testData.txt');
  }
  Future<List<String>> readFromFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsLines();
      print("Read: "+ contents.last.split(',').toString());
      return contents.last.split(',');
    } catch (e) {
      final List<String> val = <String>[];
      for(int i = 0; i < 10; i++){
        val.add('?');
      }
      // If encountering an error, return 0
      return val;
    }
  }
}