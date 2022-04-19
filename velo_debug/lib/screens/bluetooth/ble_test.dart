
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothControl{
  const BluetoothControl({Key? key, required this.device, required this.onTap});
  final BluetoothDevice device;
  final VoidCallback? onTap;
  //final BluetoothService services;

  Future<List<BluetoothService>> _services() async{
    List<BluetoothService> services = await device.discoverServices();
    return services;
  }
  List<BluetoothCharacteristic> _characteristics(){
    List<BluetoothService> services = _services() as List<BluetoothService>;
    Iterable<List<BluetoothCharacteristic>> allChar =  services.map((e) => e.characteristics);
    List<BluetoothCharacteristic> characteristics = allChar.first;
    return characteristics;
  }

  Future<void> getTheData() async {
    var list;
    for(BluetoothCharacteristic c in _characteristics()){
      List<int> value = await c.read();
      print(utf8.decode(value));
    }

  }


}