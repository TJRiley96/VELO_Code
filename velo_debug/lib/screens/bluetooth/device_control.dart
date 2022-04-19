

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceControls extends StatefulWidget {
  DeviceControls({Key? key, required this.device,}) : super(key: key);

  final BluetoothDevice device;

  @override
  State<DeviceControls> createState() => _DeviceControlsState();
}

class _DeviceControlsState extends State<DeviceControls> {
  List<String> str = ['0','0','0'];

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton(){
    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name),
        actions: <Widget>[
        StreamBuilder<BluetoothDeviceState>(
        stream: widget.device.state,
        initialData: BluetoothDeviceState.connecting,
        builder: (c, snapshot) {
          VoidCallback? onPressed;
          String text;
          switch (snapshot.data) {
            case BluetoothDeviceState.connected:
              onPressed = () => widget.device.disconnect();
              text = 'DISCONNECT';
              break;
            case BluetoothDeviceState.disconnected:
              onPressed = () => widget.device.connect();
              text = 'CONNECT';
              break;
            default:
              onPressed = null;
              text = snapshot.data.toString().substring(21).toUpperCase();
              break;
          }
          return FlatButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: Theme.of(context)
                    .primaryTextTheme
                    .button
                    ?.copyWith(color: Colors.white),
              ));
        },
      )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => setState((){
              tryAgain();
            }),
                child: Text("Stream")
            ),
            Text("Stats\n${str.elementAt(0)}\n"),
            Text("Orientation\n${str.elementAt(1)}\n"),
            Text("Flex\n${str.elementAt(2)}\n"),
          ],
        ),
      ),
    );
  }

  Future<List<BluetoothService>> _services() async{
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((s) { print("Service Number: ${s.uuid}\n\n"); print("${s.characteristics}\n\n"); });
    return services;
  }

  List<BluetoothCharacteristic> _characteristics(){
    List<BluetoothService> services = _services() as List<BluetoothService>;
    print("Services\n=========\n");
    print(services);
    Iterable<List<BluetoothCharacteristic>> allChar = services.map((e) => e.characteristics);
    List<BluetoothCharacteristic> characteristics = allChar.last;
    return characteristics;
  }

  Future<void> getTheData() async {
    var list;
    for(BluetoothCharacteristic c in _characteristics()){
      List<int> value = await c.read();
      print("Characteristics\n==========");
      print(utf8.decode(value));
    }
  }

  Future<void> tryAgain() async {

    List<BluetoothService> services = await widget.device.discoverServices();
    BluetoothService velo = services.last;
    print("Characteristics: ${velo.characteristics}\n");
    // var stats = await velo.characteristics[1].read();
    // str.insert(0, utf8.decode(stats));
    // print("UUID: ${velo.characteristics[1].uuid}\nValue: ${utf8.decode(stats)}");
    var orientation = await velo.characteristics[2].read();
    str.insert(1, utf8.decode(orientation));
    print("UUID: ${velo.characteristics[2].uuid}\nValue: ${utf8.decode(orientation)}");
    var flex = await velo.characteristics[3].read();
    str.insert(2, utf8.decode(flex));
    print("UUID: ${velo.characteristics[3].uuid}\nValue: ${utf8.decode(flex)}");
    // velo.characteristics.forEach((c) async {
    //   var num = c.uuid;
    //   print("HERE!!!!!!!!!!");
    //   print("Value: $num");
    //   var temp =
    //   var value = await c.read();
    //   print("Raw Value: $value");
    //   Character char = new Character(value: value);
    //   char.printValue();
    //   print("Decoded  : ${utf8.decode(value)}");
    // });
    //Iterable<List<int>> list = velo.characteristics.map((c) async => await c.read());

  }

  Future<String> provideData(int index) async {
    List<BluetoothService> services = await widget.device.discoverServices();
    BluetoothService velo = services.last;
    var value = await velo.characteristics[index].read();
    Character char = new Character(value: value);
    char.printValue();
    return char.getValue();
  }
}
class Character{
  Character({required this.value});
  final List<int> value;

  String getValue(){return utf8.decode(value);}
  void printValue(){
    print("Raw Value: $value");

  }
}
