import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceTest extends StatefulWidget {
  const DeviceTest({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;
  final myStream = TestAgain(d: device)

  @override
  State<DeviceTest> createState() => _DeviceTestState();
}

class _DeviceTestState extends State<DeviceTest> {
  Stream myStream = TestAgain(d: widget.device).stream;
  StreamController<String> _streamController = StreamController.broadcast();

  Future<void> refreshNums(int time, int index) async {
    final duration = Duration(seconds: time);
    List<BluetoothService> services = await widget.device.discoverServices();
    BluetoothService velo = services.last;
    var value = await velo.characteristics[index].read();
    Character char = new Character(value: value);
    Stream.periodic(duration,);
    Timer.periodic(duration, (Timer t) => _streamController.add(char.getValue()));
    char.printValue();
  }

  void initState(){

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
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
        ],
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen(){
    return StreamBuilder<String>(builder: builder)

  }
  Stream<List<int>> dataStream(int index){
    Stream<List<BluetoothService>> services = widget.device.discoverServices().asStream();
    Future<List<BluetoothService>> velo = services.last;
    var value = velo.characteristics[index].read().asStream();
    return value;
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
class TestAgain{
  TestAgain({required this.d});
  final BluetoothDevice d;

  List<String> str = [];

  Future<void> process() async{
    List<BluetoothService> services = await d.discoverServices();
    BluetoothService velo = services.last;
    var value1 = await velo.characteristics[1].read();
    var value2 = await velo.characteristics[1].read();
    var value3 = await velo.characteristics[1].read();
    str.insert(0, utf8.decode(value1));
    str.insert(1, utf8.decode(value2));
    str.insert(2, utf8.decode(value3));
  }

}
