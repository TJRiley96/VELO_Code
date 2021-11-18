import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
class FileWriter{
  FileWriter();
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/log.log');
  }

  Future<int> readFromFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeToFile(var input) async {
    final file = await _localFile;

    // Write the file
    print("File Written To!!");
    return file.writeAsString('$input');
  }
}
