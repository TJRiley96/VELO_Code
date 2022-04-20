

import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BLEStream{
  BLEStream({required this.d, this.ms = 75}){
    process();
    Timer.periodic(Duration(milliseconds: ms), (t) {
      process();
      _controller.sink.add(str);
      print(str);
    });
  }

  final BluetoothDevice d;
  final ms;
  final _controller = StreamController<List<String>>();
  List<String> str = [];
  Stream<List<String>> get stream => _controller.stream;
  Future<void> process() async{
    int len = str.length;
    List<BluetoothService> services = await d.discoverServices();
    BluetoothService velo = services.last;
    //var value1 = await velo.characteristics[1].read();
    var value2 = await velo.characteristics[2].read();
    //var value3 = await velo.characteristics[3].read();
    //str.insert(0, utf8.decode(value1));
    str.insert(0, utf8.decode(value2));
    //str.insert(2, utf8.decode(value3));
    if(len > 8){
      str.removeRange(6, 9);
    }



  }

}