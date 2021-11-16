import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:velo_debug/screens/bluetooth/ble_main.dart';


class BluetoothScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          });
  }
}