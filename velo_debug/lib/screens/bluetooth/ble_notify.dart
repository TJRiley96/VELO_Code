

import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BLENotify{
  BLENotify({required this.d, this.ms = 75}){
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
    var c = velo.characteristics[0];
    c.setNotifyValue(!c.isNotifying);
    c.value.listen((value) { str.insert(0, utf8.decode(value));});

    //str.insert(2, utf8.decode(value3));
    if(len > 8){
      str.removeRange(6, 9);
    }



  }

}