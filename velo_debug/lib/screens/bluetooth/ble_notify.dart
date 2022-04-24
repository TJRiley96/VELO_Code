

import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BLENotify{
  BLENotify({required this.d, this.ms = 100}){
    process();
    Timer.periodic(Duration(milliseconds: ms), (t) {
      //if(globals.isConnected()){
        //process();
        _controller.sink.add(str);
        print(str);
      // }else{
      //   _controller.close();
      //   t.cancel();
      // }

    });
  }

  final BluetoothDevice d;
  final ms;
  final _controller = StreamController<List<String>>();
  List<String> str = [];
  Stream<List<String>> get stream => _controller.stream;
  Future<void> process() async{
    List<BluetoothService> services = await d.discoverServices();
    BluetoothService velo = services.last;
    //var value1 = await velo.characteristics[1].read();
    var c = velo.characteristics[0];
    c.setNotifyValue(!c.isNotifying);
    c.value.listen((value) {
      //Timer.periodic(Duration(milliseconds: 5), (t){
        str.insert(0, utf8.decode(value));
        print('=================== Values in str ==================');
        print(str);
        if(str.length >= 3){
          str.removeAt(3);
          print("Items removed");
        }
     // });
    });

    //str.insert(2, utf8.decode(value3));




  }

}