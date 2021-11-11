import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


void scanForDevices(){
  FlutterBlue flutterBlue = FlutterBlue.instance;

  flutterBlue.startScan(timeout: Duration(seconds: 5));

  var subscription = flutterBlue.scanResults.listen((results) {
    for(ScanResult r in results){
      print('${r.device.name} Found! RSSI: ${r.rssi}');
    }

    flutterBlue.stopScan();
  });
}
class DeviceScreen extends StatelessWidget{
  final BluetoothDevice _device;
  return Text(device);
}