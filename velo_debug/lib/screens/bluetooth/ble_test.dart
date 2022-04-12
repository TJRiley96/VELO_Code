


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothControl{
  const BluetoothControl({Key? key, required this.device, required this.services})
      : super(key: key);
  final BluetoothDevice device;
  final BluetoothService services;

  List<BluetoothCharacteristic> _characteristics(){
    var characteristics;
    characteristics = device.services.map((event) => null);
    return characteristics;
  }


}